import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class AlertDialogWidget {
  final FirebaseService _firebaseService = FirebaseService();
  final FirestoreService _firestoreService = FirestoreService();

  createAlertDialogWidget(
    BuildContext _context,
    String _title,
    String _description,
    String _textOkButton, {
    String textCancelButton,
    String okRouteName = ContentTexts.signInRoute,
    String cancelRouteName = ContentTexts.settingRoute,
    bool isOnlyCancelButton = true,
    isOnlyOkButton = false,
    isExit = false,
    isSignOut = false,
    isSignUp = false,
    isForgotPassword = false,
    isVote = false,
    isConfirmVote = false,
    isEditProfile = false,
    isEditProfileSuccess = false,
    isChangePassword = false,
    DocumentSnapshot documentSnapshot,
    AppProviders appProviders,
    SignUpProviders signUpProviders,
    DetailPostProviders detailPostProviders,
    ChangePasswordProviders changePasswordProviders,
    EditProfileProviders editProfileProviders,
    HomeProviders homeProviders,
    MyPostsProviders myPostsProviders,
    MyVotedProviders myVotedProviders,
  }) {
    final bool _isStay = isEditProfile || isChangePassword || isExit;
    final bool _isBack = isSignUp ||
        isForgotPassword ||
        isVote ||
        isEditProfile ||
        isEditProfileSuccess ||
        isChangePassword;

    showDialog(
      barrierDismissible: false,
      context: _context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: NetworkGiffyDialog(
          image: CachedNetworkImage(
            alignment: Alignment.center,
            fit: BoxFit.cover,
            fadeInCurve: Curves.bounceIn,
            fadeOutCurve: Curves.bounceOut,
            fadeInDuration: Duration(milliseconds: 500),
            fadeOutDuration: Duration(milliseconds: 500),
            imageUrl: ContentTexts.defaultGifUrl,
            progressIndicatorBuilder: (context, url, download) => Center(
              child: Container(
                height: ContentSizes.height(context) * 0.1,
                width: ContentSizes.height(context) * 0.1,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  value: download.progress,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Center(
              child: Container(
                child: Icon(
                  Icons.error,
                  color: ContentColors.orange,
                  size: ContentSizes.height(context) * 0.15,
                ),
              ),
            ),
          ),
          cornerRadius: 20.0,
          onlyCancelButton: isOnlyCancelButton,
          onlyOkButton: isOnlyOkButton,
          buttonCancelColor: isOnlyCancelButton
              ? ContentColors.orange
              : ContentColors.backgroundGrey,
          buttonOkColor: ContentColors.orange,
          buttonRadius: 20.0,
          buttonCancelText: Text(
            isOnlyCancelButton
                ? ContentTexts.ok
                : _isStay ? ContentTexts.stay : ContentTexts.cancel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: Theme.of(_context).textTheme.headline1.copyWith(
                  color: isOnlyCancelButton ? Colors.white : ContentColors.grey,
                  fontSize: ContentSizes.dp16(_context),
                ),
          ),
          buttonOkText: Text(
            _textOkButton,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: Theme.of(_context).textTheme.headline1.copyWith(
                  color: Colors.white,
                  fontSize: ContentSizes.dp16(_context),
                ),
          ),
          title: Text(
            _title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: Theme.of(_context).textTheme.headline1.copyWith(
                  fontSize: ContentSizes.dp24(_context),
                ),
          ),
          description: Text(
            _description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: Theme.of(_context).textTheme.headline2.copyWith(
                  fontSize: ContentSizes.dp18(_context),
                ),
          ),
          onCancelButtonPressed: () {
            if (isChangePassword) {
              Navigator.popUntil(
                  _context, ModalRoute.withName(cancelRouteName));
            } else {
              Navigator.pop(_context);
            }
          },
          onOkButtonPressed: () async {
            if (isConfirmVote) {
              try {
                Navigator.pop(_context);
                appProviders.isLoading = true;
                if (!await _firestoreService.isPostOwner(documentSnapshot)) {
                  if (!await _firestoreService
                      .isAlreadyVoted(documentSnapshot)) {
                    await _firestoreService.updatePostsVote(
                      documentSnapshot,
                      detailPostProviders.selectedOption,
                      detailPostProviders.selectedIndex,
                    );
                    await _firestoreService.setVoterData(documentSnapshot);
                    await _firestoreService.fetchPostData(documentSnapshot);
                    await _firestoreService.setVotedData(documentSnapshot);
                    appProviders.isLoading = false;
                    createAlertDialogWidget(
                      _context,
                      ContentTexts.yeay,
                      ContentTexts.voteSuccessfully,
                      ContentTexts.ok,
                      okRouteName: ContentTexts.homeRoute,
                      isOnlyCancelButton: false,
                      isOnlyOkButton: true,
                      isVote: true,
                      detailPostProviders: detailPostProviders,
                    );
                  } else {
                    appProviders.isLoading = false;
                    createAlertDialogWidget(
                      _context,
                      ContentTexts.oops,
                      ContentTexts.alreadyVoted,
                      ContentTexts.ok,
                      okRouteName: ContentTexts.homeRoute,
                      isOnlyCancelButton: false,
                      isOnlyOkButton: true,
                      isVote: true,
                      detailPostProviders: detailPostProviders,
                    );
                  }
                } else {
                  appProviders.isLoading = false;
                  createAlertDialogWidget(
                    _context,
                    ContentTexts.oops,
                    ContentTexts.cantVote,
                    ContentTexts.ok,
                    okRouteName: ContentTexts.homeRoute,
                    isOnlyCancelButton: false,
                    isOnlyOkButton: true,
                    isVote: true,
                    detailPostProviders: detailPostProviders,
                  );
                }
              } catch (error) {
                appProviders.isLoading = false;
                createAlertDialogWidget(
                  _context,
                  ContentTexts.oops,
                  ContentTexts.errorUpdateVoteData,
                  ContentTexts.ok,
                );
              }
            } else if (isSignOut) {
              if (isChangePassword) {
                if (changePasswordProviders.isOldPasswordChangeVisible) {
                  changePasswordProviders.isOldPasswordChangeVisible = false;
                }
                if (changePasswordProviders.isNewPasswordChangeVisible) {
                  changePasswordProviders.isNewPasswordChangeVisible = false;
                }
                if (changePasswordProviders.isNewRepeatPasswordChangeVisible) {
                  changePasswordProviders.isNewRepeatPasswordChangeVisible =
                      false;
                }
              }
              try {
                appProviders.isLoading = true;
                await _firebaseService.signOut();
                homeProviders.resetPostsFilter();
                myPostsProviders.resetMyPostsFilter();
                myPostsProviders.saveFilterChanges();
                myVotedProviders.resetMyVotedFilter();
                myVotedProviders.saveFilterChanges();
                appProviders.isLoading = false;
                Navigator.pop(_context);
                Navigator.pushReplacementNamed(_context, okRouteName);
              } catch (error) {
                appProviders.isLoading = false;
                createAlertDialogWidget(
                  _context,
                  ContentTexts.oops,
                  ContentTexts.errorSignOut,
                  ContentTexts.ok,
                );
              }
            } else if (_isBack) {
              if (isSignUp) {
                if (signUpProviders.isPasswordSignUpVisible) {
                  signUpProviders.isPasswordSignUpVisible = false;
                }
                if (signUpProviders.isRepeatPasswordSignUpVisible) {
                  signUpProviders.isRepeatPasswordSignUpVisible = false;
                }
                if (signUpProviders.isTermsAndConditionsAccepted) {
                  signUpProviders.isTermsAndConditionsAccepted = false;
                }
              } else if (isVote) {
                if (detailPostProviders.selectedOption != '') {
                  detailPostProviders.selectedOption = '';
                }
              } else if (isEditProfile) {
                if (editProfileProviders.image != null) {
                  editProfileProviders.image = null;
                }
              } else if (isChangePassword) {
                if (changePasswordProviders.isOldPasswordChangeVisible) {
                  changePasswordProviders.isOldPasswordChangeVisible = false;
                }
                if (changePasswordProviders.isNewPasswordChangeVisible) {
                  changePasswordProviders.isNewPasswordChangeVisible = false;
                }
                if (changePasswordProviders.isNewRepeatPasswordChangeVisible) {
                  changePasswordProviders.isNewRepeatPasswordChangeVisible =
                      false;
                }
              }
              Navigator.popUntil(_context, ModalRoute.withName(okRouteName));
            } else if (isExit) {
              SystemNavigator.pop();
            } else {
              Navigator.pop(_context);
              Navigator.pushReplacementNamed(_context, okRouteName);
            }
          },
        ),
      ),
    );
  }
}
