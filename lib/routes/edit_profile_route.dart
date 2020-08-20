import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class EditProfileRoute extends StatelessWidget {
  final TextEditingController _textEditingControllerDisplayName =
          TextEditingController(),
      _textEditingControllerUsername = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();
  final BackButtonWidget _backButtonWidget = BackButtonWidget();
  final PhotoProfileWidget _photoProfileWidget = PhotoProfileWidget();
  final TextFieldWidget _textFieldWidget = TextFieldWidget();
  final ActionButtonWidget _actionButtonWidget = ActionButtonWidget();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final HiveProviders _hiveProviders = Provider.of<HiveProviders>(context);
    final EditProfileProviders _editProfileProviders =
        Provider.of<EditProfileProviders>(context);
    final UserProfileProviders _userProfileProviders =
        Provider.of<UserProfileProviders>(context);

    _onBackButtonPressed({bool isDiscard = false}) {
      if (_textEditingControllerDisplayName.text.isEmpty &&
          _textEditingControllerUsername.text.isEmpty &&
          _editProfileProviders.image == null) {
        Navigator.pop(context);
      } else {
        _alertDialogWidget.createAlertDialogWidget(
          context,
          isDiscard ? ContentTexts.discardChanges : ContentTexts.leavePage,
          isDiscard
              ? ContentTexts.discardConfirmation
              : ContentTexts.leaveConfirmation,
          isDiscard ? ContentTexts.discard : ContentTexts.leave,
          okRouteName: ContentTexts.settingRoute,
          isOnlyCancelButton: false,
          isEditProfile: true,
          editProfileProviders: _editProfileProviders,
        );
      }
    }

    Future<void> _updateUserProfile() async {
      if (_editProfileProviders.image != null) {
        try {
          final String _imageName = basename(_editProfileProviders.image.path);
          final String _photoUrl =
              await _firebaseStorageService.getPhotoProfileUrl(
            _editProfileProviders.image,
            _imageName,
          );
          try {
            _userProfileProviders.photoUrl = _photoUrl;
            _editProfileProviders.image = null;
            await _firestoreService.updatePhotoProfileUrl(_photoUrl);
          } catch (error) {
            _appProviders.isLoading = false;
            _editProfileProviders.isHasError = true;
            _alertDialogWidget.createAlertDialogWidget(
              context,
              ContentTexts.oops,
              ContentTexts.errorUpdatePhotoProfileUrl,
              ContentTexts.ok,
            );
          }
        } catch (error) {
          _appProviders.isLoading = false;
          _editProfileProviders.isHasError = true;
          _alertDialogWidget.createAlertDialogWidget(
            context,
            ContentTexts.oops,
            ContentTexts.errorGetPhotoProfileUrl,
            ContentTexts.ok,
          );
        }
      }
      if (_userProfileProviders.displayName != _hiveProviders.displayName) {
        try {
          await _firestoreService
              .updateDisplayName(_userProfileProviders.displayName);
        } catch (error) {
          _appProviders.isLoading = false;
          _editProfileProviders.isHasError = true;
          _alertDialogWidget.createAlertDialogWidget(
            context,
            ContentTexts.oops,
            ContentTexts.errorUpdateDisplayName,
            ContentTexts.ok,
          );
        }
      }
      if (_userProfileProviders.username != _hiveProviders.username) {
        try {
          await _firestoreService
              .updateUsername(_userProfileProviders.username);
        } catch (error) {
          _appProviders.isLoading = false;
          _editProfileProviders.isHasError = true;
          _alertDialogWidget.createAlertDialogWidget(
            context,
            ContentTexts.oops,
            ContentTexts.errorUpdateUsername,
            ContentTexts.ok,
          );
        }
      }
      try {
        await _firestoreService.updateLastProfileModified();
      } catch (error) {
        _appProviders.isLoading = false;
        _editProfileProviders.isHasError = true;
        _alertDialogWidget.createAlertDialogWidget(
          context,
          ContentTexts.oops,
          ContentTexts.errorUpdateLastProfileModified,
          ContentTexts.ok,
        );
      }
      await _firestoreService.fetchUserData();
      await HiveProviders.syncUserData();
      await _firestoreService.updateUsersPost();
      await _firestoreService.updatePostVoter();
      await _firestoreService.updateUserVoted();
      _hiveProviders.refreshUserData();
      if (!_editProfileProviders.isHasError) {
        _appProviders.isLoading = false;
        _alertDialogWidget.createAlertDialogWidget(
          context,
          ContentTexts.yeay,
          ContentTexts.editProfileSuccessfully,
          ContentTexts.ok,
          okRouteName: ContentTexts.settingRoute,
          isOnlyCancelButton: false,
          isOnlyOkButton: true,
          isEditProfileSuccess: true,
        );
      }
    }

    final IconButton _backButton = _backButtonWidget.createBackButton(
      context,
      ContentTexts.backToSettingRoute,
      () {
        _onBackButtonPressed();
      },
    );

    final Text _editProfileText = Text(
      ContentTexts.editProfile,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Hero _photoProfile = Hero(
      tag: ContentTexts.photoProfileTag,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            backgroundColor: ContentColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            context: context,
            builder: (context) {
              return BottomSheetWidget(
                editProfileProviders: _editProfileProviders,
                isProfile: true,
              );
            },
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _photoProfileWidget.createPhotoProfileWidget(
              ContentSizes.height(context) * 0.06,
              ContentSizes.height(context) * 0.12,
              isEditProfile: true,
              hiveProviders: _hiveProviders,
              editProfileProviders: _editProfileProviders,
            ),
            CircleAvatar(
              backgroundColor: ContentColors.black.withOpacity(0.3),
              radius: ContentSizes.height(context) * 0.06,
            ),
            Icon(
              Icons.image,
              color: ContentColors.white,
              size: 35.0,
            ),
          ],
        ),
      ),
    );

    final Container _textFieldDisplayName =
        _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerDisplayName,
      _hiveProviders.displayName,
      Icons.person,
      (input) {
        if (input.trim() != '') {
          _userProfileProviders.displayName = input.trim();
        } else {
          _userProfileProviders.displayName = _hiveProviders.displayName;
        }
      },
      isEditProfile: true,
      isDisplayName: true,
    );

    final Container _textFieldUsername = _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerUsername,
      _hiveProviders.username,
      Icons.alternate_email,
      (input) {
        if (input.trim() != '') {
          _userProfileProviders.username = input.trim();
        } else {
          _userProfileProviders.username = _hiveProviders.username;
        }
      },
      isEditProfile: true,
      isUsername: true,
    );

    final Form _editProfileForm = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _textFieldDisplayName,
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _textFieldUsername,
        ],
      ),
    );

    final Material _saveButtonWidget =
        _actionButtonWidget.createActionButtonWidget(
      context,
      ContentColors.orange,
      ContentColors.white,
      ContentTexts.save,
      () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          if (_userProfileProviders.displayName != _hiveProviders.displayName ||
              _userProfileProviders.username != _hiveProviders.username ||
              _editProfileProviders.image != null) {
            try {
              _appProviders.isLoading = true;
              if ((_userProfileProviders.displayName !=
                          _hiveProviders.displayName ||
                      _editProfileProviders.image != null) &&
                  _userProfileProviders.username == _hiveProviders.username) {
                await _updateUserProfile();
              } else {
                if (!await _firestoreService
                    .isUsernameExist(_userProfileProviders.username)) {
                  await _updateUserProfile();
                } else {
                  _appProviders.isLoading = false;
                  _alertDialogWidget.createAlertDialogWidget(
                    context,
                    ContentTexts.oops,
                    ContentTexts.usernameExistDescription,
                    ContentTexts.ok,
                  );
                }
              }
            } catch (error) {
              _appProviders.isLoading = false;
              _alertDialogWidget.createAlertDialogWidget(
                context,
                ContentTexts.oops,
                ContentTexts.errorUpdateUserProfile,
                ContentTexts.ok,
              );
            }
          } else {
            Navigator.pop(context);
          }
        }
      },
    );

    final Material _discardButtonWidget =
        _actionButtonWidget.createActionButtonWidget(
      context,
      ContentColors.backgroundDarkGrey,
      ContentColors.grey,
      ContentTexts.discard,
      () {
        _onBackButtonPressed(isDiscard: true);
      },
    );

    return _appProviders.isLoading
        ? WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Center(
                child: Loading(
                  color: ContentColors.orange,
                  indicator: BallSpinFadeLoaderIndicator(),
                  size: ContentSizes.height(context) * 0.1,
                ),
              ),
            ),
          )
        : WillPopScope(
            onWillPop: () async => _onBackButtonPressed(),
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                leading: _backButton,
                backgroundColor: ContentColors.white,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    ContentSizes.width(context) * 0.05,
                    ContentSizes.width(context) * 0.01,
                    ContentSizes.width(context) * 0.05,
                    ContentSizes.width(context) * 0.01,
                  ),
                  child: Column(
                    children: <Widget>[
                      _editProfileText,
                      SizedBox(
                        height: ContentSizes.height(context) * 0.05,
                      ),
                      _photoProfile,
                      SizedBox(
                        height: ContentSizes.height(context) * 0.05,
                      ),
                      _editProfileForm,
                      SizedBox(
                        height: ContentSizes.height(context) * 0.05,
                      ),
                      _saveButtonWidget,
                      SizedBox(
                        height: ContentSizes.height(context) * 0.01,
                      ),
                      _discardButtonWidget,
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
