import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class SignInRoute extends StatefulWidget {
  @override
  _SignInRouteState createState() => _SignInRouteState();
}

class _SignInRouteState extends State<SignInRoute> {
  final TextEditingController _textEditingControllerEmail =
          TextEditingController(),
      _textEditingControllerPassword = TextEditingController();
  final FacebookService _facebookService = FacebookService();
  final FirebaseService _firebaseService = FirebaseService();
  final FirestoreService _firestoreService = FirestoreService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    HiveProviders.setFirstOpened();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final HiveProviders _hiveProviders =
        Provider.of<HiveProviders>(context, listen: false);
    final SignInProviders _signInProviders =
        Provider.of<SignInProviders>(context);
    final AlertDialogWidget _alertDialogWidget = AlertDialogWidget(context);

    final TextFieldWidget _textFieldEmailWidget = TextFieldWidget(
      context,
      _textEditingControllerEmail,
      'Email',
      Icons.email,
      (input) {
        _signInProviders.emailSignIn = input.trim();
      },
      isRegistered: true,
    );

    final TextFieldWidget _textFieldPasswordWidget = TextFieldWidget(
      context,
      _textEditingControllerPassword,
      'Password',
      Icons.lock,
      (input) {
        _signInProviders.passwordSignIn = input.trim();
      },
      isRegistered: true,
      isPasswordSignIn: true,
    );

    final ActionButtonWidget _signInEmailAndPaswordButtonWidget =
        ActionButtonWidget(
      context,
      ContentColors.orange,
      ContentTexts.signIn,
      () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          try {
            _appProviders.isLoading = true;
            await _firebaseService.signInWithEmailPassword(
              _signInProviders.emailSignIn,
              _signInProviders.passwordSignIn,
            );
            _hiveProviders.setUserData();
            _signInProviders.createUserModel();
            _firestoreService.createUser(_signInProviders.userModel);
            // TODO FIX ROUTING
            if (!HiveProviders.getFirstSignedIn()) {
              Navigator.pushReplacementNamed(context, '/homeRoute');
            } else {
              Navigator.pushReplacementNamed(context, '/introductionRoute');
            }
            _signInProviders.isPasswordSignInVisible = false;
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

    final ActionButtonWidget _signInFacebookButtonWidget = ActionButtonWidget(
      context,
      ContentColors.facebook,
      ContentTexts.signInWithFacebook,
      () async {
        try {
          _appProviders.isLoading = true;
          await _facebookService.signInWithFacebook();
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
      isFacebook: true,
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
                      color: ContentColors.orange,
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
            color: ContentColors.grey,
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
            color: ContentColors.grey,
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
                  color: ContentColors.orange,
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
                        _signInEmailAndPaswordButtonWidget.createSignInWidget(),
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
                        _signInFacebookButtonWidget.createSignInWidget(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
