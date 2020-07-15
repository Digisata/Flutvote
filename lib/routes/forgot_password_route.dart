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
  final FirebaseAuths _firebaseAuths = FirebaseAuths();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final ForgotPasswordProviders _forgotPasswordProviders =
        Provider.of<ForgotPasswordProviders>(context);

    final AlertDialogWidget _alertDialogWidget = AlertDialogWidget(context);

    final TextFieldWidget _textFieldEmailWidget = TextFieldWidget(
      context,
      _textEditingControllerEmail,
      'Email',
      true,
      false,
      Icons.email,
      (input) {
        _forgotPasswordProviders.emailForgotPassword = input.trim();
      },
    );

    final BackButtonWidget _backButtonWidget = BackButtonWidget(
      context,
      ContentTexts.backToSignInRoute,
      () {
        Navigator.pop(context);
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

    final Form _resetForm = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _textFieldEmailWidget.createTextFieldWidget(),
        ],
      ),
    );

    final ActionButtonWidget _resetEmailWidget = ActionButtonWidget(
      context,
      ColorPalettes.orange,
      ContentTexts.resetPassword,
      false,
      () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          try {
            _appProviders.isLoading = true;
            await _firebaseAuths
                .resetPassword(_textEditingControllerEmail.text.trim());
            _appProviders.isLoading = false;
            _alertDialogWidget.createAlertDialogWidget(
              ContentTexts.yeay,
              'Password reset email already sent to ${_forgotPasswordProviders.emailForgotPassword}, please confirm that!',
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
                color: ColorPalettes.orange,
                indicator: BallSpinFadeLoaderIndicator(),
                size: ContentSizes.height(context) * 0.1,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              leading: _backButtonWidget.createBackButton(),
              backgroundColor: ColorPalettes.white,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
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
                          _resetEmailWidget.createSignInWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
