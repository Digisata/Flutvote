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
  final GlobalKey<FormState> _formlKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);

    final AlertDialogWidget _alertDialogWidget = AlertDialogWidget(context);

    final TextFieldWidget _textFieldEmailWidget = TextFieldWidget(
      context,
      _textEditingControllerEmail,
      'Email',
      true,
      false,
      Icons.email,
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
      key: _formlKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _textFieldEmailWidget.createTextFieldWidget(),
        ],
      ),
    );

    final SignInWidget _resetEmailWidget = SignInWidget(
      context,
      ColorPalettes.orange,
      ContentTexts.resetPassword,
      false,
      () async {
        if (_formlKey.currentState.validate()) {
          try {
            _appProviders.isLoading = true;
            await _firebaseAuths
                .resetPassword(_textEditingControllerEmail.text.trim());
            _appProviders.emailInput = _textEditingControllerEmail.text.trim();
            _appProviders.isLoading = false;
            _alertDialogWidget.createAlertDialogWidget(
              ContentTexts.yeay,
              'Password reset email already sent to ${_appProviders.emailInput}, please confirm that!',
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

    return Scaffold(
      body: SafeArea(
        child: _appProviders.isLoading
            ? Center(
                child: Loading(
                  color: ColorPalettes.orange,
                  indicator: BallSpinFadeLoaderIndicator(),
                  size: ContentSizes.height(context) * 0.1,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _backButtonWidget.createBackButton(),
                      ],
                    ),
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
