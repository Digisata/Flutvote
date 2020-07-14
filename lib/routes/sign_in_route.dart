import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class SignInRoute extends StatelessWidget {
  final TextEditingController _textEditingControllerEmail =
          TextEditingController(),
      _textEditingControllerPassword = TextEditingController();
  final FacebookAuths _facebookAuths = FacebookAuths();
  final FirebaseAuths _firebaseAuths = FirebaseAuths();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

    final TextFieldWidget _textFieldPasswordWidget = TextFieldWidget(
      context,
      _textEditingControllerPassword,
      'Password',
      true,
      true,
      Icons.lock,
    );

    final SignInWidget _signInEmailAndPaswordWidget = SignInWidget(
      context,
      ColorPalettes.orange,
      ContentTexts.signIn,
      false,
      () async {
        if (_formKey.currentState.validate()) {
          try {
            _appProviders.isLoading = true;
            await _firebaseAuths.signInWithEmailPassword(
              _textEditingControllerEmail.text.trim(),
              _textEditingControllerPassword.text.trim(),
            );
            _appProviders.emailInput = _textEditingControllerEmail.text.trim();
            _appProviders.passwordInput =
                _textEditingControllerPassword.text.trim();
            Navigator.pushReplacementNamed(context, '/introductionRoute');
            _appProviders.isLoading = false;
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

    final SignInWidget _signInFacebookWidget = SignInWidget(
      context,
      ColorPalettes.facebook,
      ContentTexts.signInWithFacebook,
      true,
      () async {
        try {
          _appProviders.isLoading = true;
          await _facebookAuths.signInWithFacebook();
          Navigator.pushReplacementNamed(context, '/introductionRoute');
          _appProviders.isLoading = false;
        } catch (error) {
          _appProviders.isLoading = false;
          _alertDialogWidget.createAlertDialogWidget(
            ContentTexts.oops,
            error,
            ContentTexts.ok,
          );
        }
      },
    );

    final Text _signInText = Text(
      ContentTexts.signIn,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Form _signInForm = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _textFieldEmailWidget.createTextFieldWidget(),
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _textFieldPasswordWidget.createTextFieldWidget(),
        ],
      ),
    );

    final Row _forgotText = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/forgotPasswordRoute');
          },
          child: Text(
            ContentTexts.forgotPassword,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize: ContentSizes.dp12(context),
                ),
          ),
        ),
      ],
    );

    final Row _signUpText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize: ContentSizes.dp14(context),
                ),
            children: <TextSpan>[
              TextSpan(
                text: ContentTexts.dontHaveAccount,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: ContentSizes.dp12(context),
                    ),
              ),
              TextSpan(
                text: ContentTexts.signUp,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: ColorPalettes.orange,
                      fontSize: ContentSizes.dp12(context),
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/signUpRoute');
                  },
              ),
            ],
          ),
        ),
      ],
    );

    final Row _orText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Divider(
            color: ColorPalettes.grey,
            height: ContentSizes.height(context) * 0.01,
            thickness: 1.0,
            endIndent: 10.0,
          ),
        ),
        Text(
          ContentTexts.or,
          style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize: ContentSizes.dp12(context),
              ),
        ),
        Expanded(
          child: Divider(
            color: ColorPalettes.grey,
            height: ContentSizes.height(context) * 0.01,
            thickness: 1.0,
            indent: 10.0,
          ),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _appProviders.isLoading
              ? Loading(
                  color: ColorPalettes.orange,
                  indicator: BallSpinFadeLoaderIndicator(),
                  size: ContentSizes.height(context) * 0.1,
                )
              : SingleChildScrollView(
                  child: Padding(
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
                        _signInText,
                        SizedBox(
                          height: ContentSizes.height(context) * 0.05,
                        ),
                        _signInForm,
                        SizedBox(
                          height: ContentSizes.height(context) * 0.02,
                        ),
                        _forgotText,
                        SizedBox(
                          height: ContentSizes.height(context) * 0.03,
                        ),
                        _signInEmailAndPaswordWidget.createSignInWidget(),
                        SizedBox(
                          height: ContentSizes.height(context) * 0.05,
                        ),
                        _signUpText,
                        SizedBox(
                          height: ContentSizes.height(context) * 0.02,
                        ),
                        _orText,
                        SizedBox(
                          height: ContentSizes.height(context) * 0.05,
                        ),
                        _signInFacebookWidget.createSignInWidget(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
