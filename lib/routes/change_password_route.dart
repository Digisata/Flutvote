import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class ChangePasswordRoute extends StatelessWidget {
  final TextEditingController _textEditingControllerOldPassword =
          TextEditingController(),
      _textEditingControllerNewPassword = TextEditingController(),
      _textEditingControllerNewRepeatPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseService = FirebaseService();
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();
  final ActionButtonWidget _actionButtonWidget = ActionButtonWidget();
  final BackButtonWidget _backButtonWidget = BackButtonWidget();
  final TextFieldWidget _textFieldWidget = TextFieldWidget();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final ChangePasswordProviders _changePasswordProviders =
        Provider.of<ChangePasswordProviders>(context);
    final HiveProviders _hiveProviders = Provider.of<HiveProviders>(context);

    _onBackButtonPressed({bool isDiscard = false}) {
      if (_textEditingControllerOldPassword.text.isEmpty &&
          _textEditingControllerNewPassword.text.isEmpty &&
          _textEditingControllerNewRepeatPassword.text.isEmpty) {
        _changePasswordProviders.isOldPasswordChangeVisible = false;
        _changePasswordProviders.isNewPasswordChangeVisible = false;
        _changePasswordProviders.isNewRepeatPasswordChangeVisible = false;
        Navigator.pop(context);
      } else {
        _alertDialogWidget.createAlertDialogWidget(
          context,
          isDiscard ? ContentTexts.discardChanges : ContentTexts.leavePage,
          isDiscard
              ? ContentTexts.discardConfirmation
              : ContentTexts.leaveConfirmation,
          isDiscard ? ContentTexts.discard : ContentTexts.leave,
          isOnlyCancelButton: false,
          isChangePassword: true,
          changePasswordProviders: _changePasswordProviders,
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

    final Text _changePasswordText = Text(
      ContentTexts.changePassword,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Container _textFieldOldPassword =
        _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerOldPassword,
      ContentTexts.oldPassword,
      Icons.lock,
      (input) {
        _changePasswordProviders.oldPasswordChange = input.trim();
      },
      isRegistered: true,
      isOldPassword: true,
    );

    final Container _textFieldNewPassword =
        _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerNewPassword,
      ContentTexts.newPassword,
      Icons.lock,
      (input) {
        _changePasswordProviders.newPasswordChange = input.trim();
      },
      isNewPassword: true,
    );

    final Container _textFieldNewRepeatPassword =
        _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerNewRepeatPassword,
      ContentTexts.repeatPassword,
      Icons.lock,
      (input) {
        _changePasswordProviders.newRepeatPasswordChange = input.trim();
      },
      isRepeatChangePassword: true,
    );

    final Form _changePasswordForm = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _textFieldOldPassword,
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _textFieldNewPassword,
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _textFieldNewRepeatPassword,
        ],
      ),
    );

    final Material _changePaswordButtonWidget =
        _actionButtonWidget.createActionButtonWidget(
      context,
      ContentColors.orange,
      ContentColors.white,
      ContentTexts.changePassword,
      () async {
        _changePasswordProviders.newPasswordChange =
            _textEditingControllerNewPassword.text.trim();
        _changePasswordProviders.newRepeatPasswordChange =
            _textEditingControllerNewRepeatPassword.text.trim();
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          try {
            _appProviders.isLoading = true;
            final bool _isPasswordValid = await _firebaseService
                .validatePassword(_changePasswordProviders.oldPasswordChange);
            if (_isPasswordValid) {
              await _firebaseService
                  .updatePassword(_changePasswordProviders.newPasswordChange);
            }
            _hiveProviders
                .setPassword(_changePasswordProviders.newPasswordChange);
            _appProviders.isLoading = false;
            _alertDialogWidget.createAlertDialogWidget(
              context,
              ContentTexts.yeay,
              ContentTexts.changePasswordSuccessfully,
              ContentTexts.signIn,
              isOnlyCancelButton: false,
              isOnlyOkButton: true,
              isSignOut: true,
              isChangePassword: true,
              appProviders: _appProviders,
              changePasswordProviders: _changePasswordProviders,
            );
          } catch (error) {
            _appProviders.isLoading = false;
            _alertDialogWidget.createAlertDialogWidget(
              context,
              ContentTexts.oops,
              error,
              ContentTexts.ok,
            );
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _changePasswordText,
                      SizedBox(
                        height: ContentSizes.height(context) * 0.05,
                      ),
                      _changePasswordForm,
                      SizedBox(
                        height: ContentSizes.height(context) * 0.05,
                      ),
                      _changePaswordButtonWidget,
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
