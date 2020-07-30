import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class EditProfileRoute extends StatelessWidget {
  final TextEditingController _textEditingControllerDisplayName =
          TextEditingController(),
      _textEditingControllerUsername = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
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
    final UserProfileProviders _userProfileProviders =
        Provider.of<UserProfileProviders>(context);

    _onBackButtonPressed({bool isDiscard = false}) {
      if (_textEditingControllerDisplayName.text.isEmpty &&
          _textEditingControllerUsername.text.isEmpty) {
        Navigator.pop(context);
      } else {
        _alertDialogWidget.createAlertDialogWidget(
          context,
          isDiscard ? ContentTexts.discardChanges : ContentTexts.leavePage,
          isDiscard
              ? ContentTexts.discardConfirmation
              : ContentTexts.leaveConfirmation,
          isDiscard ? ContentTexts.discard : ContentTexts.leave,
          routeName: ContentTexts.settingRoute,
          isOnlyCancelButton: false,
          isEditProfile: true,
        );
      }
    }

    void _updateUsernameAndDisplayName() async {
      await _firestoreService
          .updateUsernameAndDisplayName(AppProviders.userModel);
      await _firestoreService.fetchUserData();
      await HiveProviders.syncUserData();
      _hiveProviders.refreshUserData();
      _appProviders.isLoading = false;
      _alertDialogWidget.createAlertDialogWidget(
        context,
        ContentTexts.yeay,
        ContentTexts.editProfileSuccessfully,
        ContentTexts.ok,
        routeName: ContentTexts.settingRoute,
        isOnlyCancelButton: false,
        isOnlyOkButton: true,
        isEditProfile: true,
      );
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
      tag: 'photoProfile',
      child: _photoProfileWidget.createPhotoProfileWidget(
        ContentSizes.height(context) * 0.06,
        ContentSizes.height(context) * 0.12,
      ),
    );

    final Container _textFieldDisplayName =
        _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerDisplayName,
      _hiveProviders.displayName,
      Icons.account_circle,
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
              _userProfileProviders.username != _hiveProviders.username) {
            try {
              _appProviders.isLoading = true;
              AppProviders.setUserModel = UserModel(
                username: _userProfileProviders.username,
                displayName: _userProfileProviders.displayName,
              );
              if (_userProfileProviders.displayName !=
                      _hiveProviders.displayName &&
                  _userProfileProviders.username == _hiveProviders.username) {
                _updateUsernameAndDisplayName();
              } else {
                if (!await _firestoreService
                    .isUsernameExist(_userProfileProviders.username)) {
                  _updateUsernameAndDisplayName();
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
              throw 'edit profile error: $error';
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
