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
    String routeName = '/signInRoute',
    bool isOnlyCancelButton = true,
    isOnlyOkButton = false,
    isExit = false,
    isSignOut = false,
    isSignUp = false,
    isForgotPassword = false,
    isVote = false,
    isConfirmVote = false,
    isEditProfile = false,
    isChangePassword = false,
    DocumentSnapshot documentSnapshot,
    AppProviders appProviders,
    SignUpProviders signUpProviders,
    DetailPostProviders detailPostProviders,
    ChangePasswordProviders changePasswordProviders,
  }) {
    final bool _isStay = isEditProfile || isChangePassword || isExit;
    final bool _isBack = isSignUp ||
        isForgotPassword ||
        isVote ||
        isEditProfile ||
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
            imageUrl:
                'https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF\'s/gif14.gif',
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
                  color: isOnlyCancelButton
                      ? ContentColors.white
                      : ContentColors.grey,
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
                  color: ContentColors.white,
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
          // TODO FIX THIS ROUTING
          onCancelButtonPressed: () {
            Navigator.pop(_context);
          },
          onOkButtonPressed: () async {
            if (isSignOut) {
              try {
                await _firebaseService.signOut();
                Navigator.pop(_context, true);
                Navigator.pushReplacementNamed(_context, routeName);
              } catch (error) {
                throw 'Sign out error: $error';
              }
            } else if (_isBack) {
              if (isSignUp) {
                signUpProviders.isPasswordSignUpVisible = false;
                signUpProviders.isRepeatPasswordSignUpVisible = false;
              } else if (isVote) {
                detailPostProviders.selectedOption = '';
              } else if (isChangePassword) {
                changePasswordProviders.isOldPasswordChangeVisible = false;
                changePasswordProviders.isNewPasswordChangeVisible = false;
                changePasswordProviders.isNewRepeatPasswordChangeVisible =
                    false;
              }
              Navigator.pop(_context, true);
              Navigator.pop(_context, true);
            } else if (isExit) {
              SystemNavigator.pop();
            } else if (isConfirmVote) {
              try {
                appProviders.isLoading = true;
                await _firestoreService.updateVoteData(
                  documentSnapshot,
                  detailPostProviders.selectedOption,
                  detailPostProviders.index,
                );
                appProviders.isLoading = false;
                Navigator.pop(_context, true);
                createAlertDialogWidget(
                  _context,
                  ContentTexts.thankYou,
                  ContentTexts.thankYouDescription,
                  ContentTexts.ok,
                  routeName: '/homeRoute',
                  isOnlyCancelButton: false,
                  isOnlyOkButton: true,
                );
              } catch (error) {
                throw 'Update vote data error: $error';
              }
            } else {
              Navigator.pop(_context, true);
              Navigator.pushReplacementNamed(_context, routeName);
            }
          },
        ),
      ),
    );
  }
}
