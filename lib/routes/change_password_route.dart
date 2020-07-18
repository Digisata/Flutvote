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
  final FirebaseService _firebaseService = FirebaseService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final ChangePasswordProviders _changePasswordProviders =
        Provider.of<ChangePasswordProviders>(context);

    final AlertDialogWidget _alertDialogWidget = AlertDialogWidget(context);

    final TextFieldWidget _textFieldOldPasswordWidget = TextFieldWidget(
      context,
      _textEditingControllerOldPassword,
      ContentTexts.oldPassword,
      Icons.lock,
      (input) {
        _changePasswordProviders.isOldPasswordChangeVisible = false;
      },
    );

    final TextFieldWidget _textFieldNewPasswordWidget = TextFieldWidget(
      context,
      _textEditingControllerNewPassword,
      ContentTexts.newPassword,
      Icons.lock,
      (input) {
        _changePasswordProviders.isNewPasswordChangeVisible = false;
      },
    );

    final TextFieldWidget _textFieldNewRepeatPasswordWidget = TextFieldWidget(
      context,
      _textEditingControllerNewRepeatPassword,
      ContentTexts.repeatPassword,
      Icons.lock,
      (input) {
        _changePasswordProviders.isNewRepeatPasswordChangeVisible = false;
      },
    );

    final BackButtonWidget _backButtonWidget = BackButtonWidget(
      context,
      ContentTexts.backToProfileRoute,
      () {
        Navigator.pop(context);
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

    final Form _changePasswordForm = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _textFieldOldPasswordWidget.createTextFieldWidget(),
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _textFieldNewPasswordWidget.createTextFieldWidget(),
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _textFieldNewRepeatPasswordWidget.createTextFieldWidget(),
        ],
      ),
    );

    final ActionButtonWidget _changePaswordButtonWidget = ActionButtonWidget(
      context,
      ContentColors.orange,
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
            // TODO CHANGE TO UPDATE PASSWORD
            await _firebaseService.signUpWithEmailAndPassword(
              _textEditingControllerOldPassword.text.trim(),
              _textEditingControllerNewPassword.text.trim(),
            );
            _appProviders.isLoading = false;
            _alertDialogWidget.createAlertDialogWidget(
              ContentTexts.yeay,
              ContentTexts.updatePasswordSuccessfully,
              ContentTexts.signIn,
            );
          } catch (error) {
            _appProviders.isLoading = false;
            _alertDialogWidget.createAlertDialogWidget(
              ContentTexts.oops,
              error,
              ContentTexts.ok,
            );
          }
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
              leading: _backButtonWidget.createBackButton(),
              backgroundColor: ContentColors.white,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      ContentSizes.width(context) * 0.1,
                      ContentSizes.height(context) * 0.2,
                      ContentSizes.width(context) * 0.1,
                      ContentSizes.height(context) * 0.2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _changePasswordText,
                        SizedBox(
                          height: ContentSizes.height(context) * 0.05,
                        ),
                        _changePasswordForm,
                        SizedBox(
                          height: ContentSizes.height(context) * 0.05,
                        ),
                        _changePaswordButtonWidget.createActionButtonWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
