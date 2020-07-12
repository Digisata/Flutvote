import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';

class SignUpRoute extends StatelessWidget {
  final TextEditingController _textEditingControllerEmail =
          TextEditingController(),
      _textEditingControllerPassword = TextEditingController(),
      _textEditingControllerConfirmPassword = TextEditingController();
  final FirebaseAuths _firebaseAuths = FirebaseAuths();
  final GlobalKey<FormState> _formlKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextFieldWidget _textFieldEmailWidget = TextFieldWidget(
      context,
      _textEditingControllerEmail,
      'Email',
      false,
      Icons.email,
    );

    final TextFieldWidget _textFieldPasswordWidget = TextFieldWidget(
      context,
      _textEditingControllerPassword,
      'Password',
      false,
      Icons.lock,
    );

    final TextFieldWidget _textFieldConfirmPasswordWidget = TextFieldWidget(
      context,
      _textEditingControllerConfirmPassword,
      'Confirm password',
      false,
      Icons.lock,
    );

    final IconButton _backButton = IconButton(
      icon: Image.asset(
        'assets/buttons/back_button.png',
        height: ContentSizes.height(context) * 0.03,
        width: ContentSizes.height(context) * 0.03,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    final Text _signUpText = Text(
      ContentTexts.signUp,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final SignInWidget _signUpEmailAndPaswordWidget = SignInWidget(
      context,
      ColorPalettes.orange,
      ContentTexts.signUp,
      false,
      () async {
        // TODO ADD DIDNT MATCH MESSAGE
        if (_formlKey.currentState.validate()) {
          try {
            await _firebaseAuths.signUpWithEmailAndPassword(
              _textEditingControllerEmail.text.trim(),
              _textEditingControllerPassword.text.trim(),
            );
            Navigator.pushReplacementNamed(context, '/homeRoute');
          } catch (error) {
            throw 'sign up with email and password error: $error';
          }
        }
      },
    );

    final Row _signInText = Row(
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
                text: ContentTexts.alreadyHaveAccount,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: ContentSizes.dp12(context),
                    ),
              ),
              TextSpan(
                text: ContentTexts.signIn,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: ColorPalettes.orange,
                      fontSize: ContentSizes.dp12(context),
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pop(context);
                  },
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: _backButton,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
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
                _signUpText,
                SizedBox(
                  height: ContentSizes.height(context) * 0.05,
                ),
                Form(
                  key: _formlKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _textFieldEmailWidget.createTextFieldWidget(),
                      SizedBox(
                        height: ContentSizes.height(context) * 0.03,
                      ),
                      _textFieldPasswordWidget.createTextFieldWidget(),
                      SizedBox(
                        height: ContentSizes.height(context) * 0.03,
                      ),
                      _textFieldConfirmPasswordWidget.createTextFieldWidget(),
                    ],
                  ),
                ),
                SizedBox(
                  height: ContentSizes.height(context) * 0.05,
                ),
                _signUpEmailAndPaswordWidget.createSignInWidget(),
                SizedBox(
                  height: ContentSizes.height(context) * 0.05,
                ),
                _signInText,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
