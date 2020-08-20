import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class ForgotPasswordRoute extends StatelessWidget {
  final TextEditingController _textEditingControllerEmail =
      TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();
  final BackButtonWidget _backButtonWidget = BackButtonWidget();
  final TextFieldWidget _textFieldWidget = TextFieldWidget();
  final ActionButtonWidget _actionButtonWidget = ActionButtonWidget();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final ForgotPasswordProviders _forgotPasswordProviders =
        Provider.of<ForgotPasswordProviders>(context);

    _onBackButtonPressed() {
      Navigator.pop(context, true);
    }

    final IconButton _backButton = _backButtonWidget.createBackButton(
      context,
      ContentTexts.backToSignInRoute,
      () {
        _onBackButtonPressed();
      },
    );

    final Text _resetText = Text(
      ContentTexts.forgotPassword,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Text _descriptionText = Text(
      ContentTexts.resetPasswordDescription,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline2.copyWith(
            fontSize: ContentSizes.dp18(context),
          ),
    );

    final Container _textFieldEmail = _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerEmail,
      ContentTexts.email,
      Icons.email,
      (input) {
        _forgotPasswordProviders.emailForgotPassword = input.trim();
      },
      isRegistered: true,
      isEmail: true,
    );

    final Form _resetForm = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _textFieldEmail,
        ],
      ),
    );

    final Material _resetPasswordButtonWidget =
        _actionButtonWidget.createActionButtonWidget(
      context,
      ContentColors.orange,
      ContentColors.white,
      ContentTexts.resetPassword,
      () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          try {
            _appProviders.isLoading = true;
            await _firebaseService
                .resetPassword(_forgotPasswordProviders.emailForgotPassword);
            _appProviders.isLoading = false;
            _alertDialogWidget.createAlertDialogWidget(
              context,
              ContentTexts.yeay,
              'Password reset email already sent to ${_forgotPasswordProviders.emailForgotPassword}, please confirm that!',
              ContentTexts.signIn,
              isOnlyCancelButton: false,
              isOnlyOkButton: true,
              isForgotPassword: true,
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
                    ContentSizes.height(context) * 0.01,
                    ContentSizes.width(context) * 0.05,
                    ContentSizes.height(context) * 0.01,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _resetText,
                      SizedBox(
                        height: ContentSizes.height(context) * 0.02,
                      ),
                      _descriptionText,
                      SizedBox(
                        height: ContentSizes.height(context) * 0.05,
                      ),
                      _resetForm,
                      SizedBox(
                        height: ContentSizes.height(context) * 0.05,
                      ),
                      _resetPasswordButtonWidget,
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
