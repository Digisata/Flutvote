import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';

class SignInRoute extends StatelessWidget {
  final TextEditingController _textEditingControllerEmail =
          TextEditingController(),
      _textEditingControllerPassword = TextEditingController();
  final FacebookAuths _facebookAuths = FacebookAuths();
  final FirebaseAuths _firebaseAuths = FirebaseAuths();

  @override
  Widget build(BuildContext context) {
    final TextFieldWidget _textFieldEmailWidget = TextFieldWidget(
      context,
      _textEditingControllerEmail,
      'Email',
      Icons.email,
    );
    final TextFieldWidget _textFieldPasswordWidget = TextFieldWidget(
      context,
      _textEditingControllerPassword,
      'Password',
      Icons.lock,
    );
    final SignInWidget _signInEmailAndPaswordWidget = SignInWidget(
      context,
      ColorPalettes.orange,
      ContentTexts.signIn,
      () async {
        try {
          await _firebaseAuths.signInWithEmailPassword(
            _textEditingControllerEmail.text,
            _textEditingControllerPassword.text,
          );
          Navigator.pushReplacementNamed(context, '/homeRoute');
        } catch (error) {
          throw 'sign in with email and password error: $error';
        }
      },
    );
    final SignInWidget _signInFacebookWidget = SignInWidget(
      context,
      ColorPalettes.facebook,
      ContentTexts.signInWithFacebook,
      () async {
        try {
          await _facebookAuths.signInWithFacebook();
          Navigator.pushReplacementNamed(context, '/homeRoute');
        } catch (error) {
          throw 'sign in with facebook error: $error';
        }
      },
    );

    final Row _forgotText = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
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

    final Row _registerText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
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
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ],
    );

    final Row _orText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Or',
          style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize: ContentSizes.dp12(context),
              ),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              ContentSizes.width(context) * 0.1,
              ContentSizes.height(context) * 0.2,
              ContentSizes.width(context) * 0.1,
              ContentSizes.height(context) * 0.2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  ContentTexts.signIn,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: ContentSizes.dp24(context),
                      ),
                ),
                SizedBox(
                  height: ContentSizes.height(context) * 0.05,
                ),
                _textFieldEmailWidget.createTextFieldWidget(),
                SizedBox(
                  height: ContentSizes.height(context) * 0.03,
                ),
                _textFieldPasswordWidget.createTextFieldWidget(),
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
                _registerText,
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
    );
  }
}
