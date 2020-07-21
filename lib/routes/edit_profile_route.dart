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
    final EditProfileProviders _editProfileProviders =
        Provider.of<EditProfileProviders>(context);

    final IconButton _backButton = _backButtonWidget.createBackButton(
      context,
      ContentTexts.backToSettingRoute,
      () {
        Navigator.pop(context);
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

    final Hero _photoProfile = _photoProfileWidget.createPhotoProfileWidget(
      ContentSizes.height(context) * 0.06,
      ContentSizes.height(context) * 0.12,
    );

    final Container _textFieldDisplayName =
        _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerDisplayName,
      _hiveProviders.displayName,
      Icons.account_circle,
      (input) {
        _editProfileProviders.displayNameChange = input.trim();
      },
      isEditProfile: true,
      isRegistered: true,
    );

    final Container _textFieldUsername = _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerUsername,
      _hiveProviders.username,
      Icons.alternate_email,
      (input) {
        _editProfileProviders.usernameChange = input.trim();
      },
      isEditProfile: true,
      isRegistered: true,
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
          try {
            _appProviders.isLoading = true;
            AppProviders.setUserModel = UserModel(
              username: _editProfileProviders.usernameChange,
              displayName: _editProfileProviders.displayNameChange,
            );
            await _firestoreService.updateUserData(AppProviders.userModel);
            HiveProviders.syncUserData();
            _appProviders.isLoading = false;
            _alertDialogWidget.createAlertDialogWidget(
              context,
              ContentTexts.yeay,
              ContentTexts.editProfileSuccessfully,
              ContentTexts.ok,
              routeName: '/settingRoute',
              isOnlyCancelButton: false,
              isOnlyOkButton: true,
            );
          } catch (error) {
            throw 'save error: $error';
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
        if (_textEditingControllerDisplayName.text.isEmpty &&
            _textEditingControllerUsername.text.isEmpty) {
          Navigator.pop(context);
        } else {
          _alertDialogWidget.createAlertDialogWidget(
            context,
            ContentTexts.discardChanges,
            ContentTexts.discardConfirmation,
            ContentTexts.discard,
            routeName: '/settingRoute',
            isOnlyCancelButton: false,
          );
        }
      },
    );

    return _appProviders.isLoading
        ? Scaffold(
            body: Center(
              child: Loading(
                color: ContentColors.orange,
                indicator: BallSpinFadeLoaderIndicator(),
                size: ContentSizes.height(context) * 0.1,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              leading: _backButton,
              backgroundColor: ContentColors.white,
            ),
            body: Padding(
              padding: EdgeInsets.all(ContentSizes.width(context) * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
          );
  }
}
