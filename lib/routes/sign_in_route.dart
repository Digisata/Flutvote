import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/model/models.dart';
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
  final FacebookService _facebookService = FacebookService();
  final FirebaseService _firebaseService = FirebaseService();
  final FirestoreService _firestoreService = FirestoreService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();
  final TextFieldWidget _textFieldWidget = TextFieldWidget();
  final ActionButtonWidget _actionButtonWidget = ActionButtonWidget();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final SignInProviders _signInProviders =
        Provider.of<SignInProviders>(context);
    final HiveProviders _hiveProviders = Provider.of<HiveProviders>(context);

    _exitApp() {
      _alertDialogWidget.createAlertDialogWidget(
        context,
        ContentTexts.exitApp,
        ContentTexts.exitAppConfirmation,
        ContentTexts.exit,
        isOnlyCancelButton: false,
        isExit: true,
      );
    }

    Future<void> _signIn({bool isSignInWithFacebook = false}) async {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      if (!await _firestoreService.isAlreadyRegistered()) {
        AppProviders.setUserModel = UserModel(
          deviceId: _hiveProviders.deviceId,
          displayName: ContentTexts.displayName,
          email: _user.email,
          is2FaConfigured: false,
          isFingerprintConfigured: false,
          isPinConfigured: false,
          isSetupCompleted: false,
          lastPasswordModified: Timestamp.now(),
          lastProfileModified: Timestamp.now(),
          photoUrl: ContentTexts.defaultPhotoUrl,
          username: ContentTexts.username,
        );
        await _firestoreService.setUserData(AppProviders.userModel);
      }
      if (!isSignInWithFacebook) {
        _hiveProviders.setPassword(_signInProviders.passwordSignIn);
      }
      await _firestoreService.fetchUserData();
      await HiveProviders.syncUserData();
      if (!HiveProviders.getFirstSignedIn()) {
        if (!HiveProviders.getIsSetupCompleted()) {
          Navigator.pushReplacementNamed(
              context, ContentTexts.introductionRoute);
        } else {
          Navigator.pushReplacementNamed(context, ContentTexts.homeRoute);
        }
      } else if (await _firestoreService.isAlreadyRegistered() &&
          HiveProviders.getIsSetupCompleted()) {
        HiveProviders.setFirstSignedIn();
        Navigator.pushReplacementNamed(context, ContentTexts.homeRoute);
      } else {
        HiveProviders.setFirstSignedIn();
        Navigator.pushReplacementNamed(context, ContentTexts.introductionRoute);
      }
      if (!isSignInWithFacebook) {
        if (_signInProviders.isPasswordSignInVisible) {
          _signInProviders.isPasswordSignInVisible = false;
        }
      }
      _appProviders.isLoading = false;
    }

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

    final Container _textFieldEmail = _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerEmail,
      ContentTexts.email,
      Icons.email,
      (input) {
        _signInProviders.emailSignIn = input.trim();
      },
      isRegistered: true,
      isEmail: true,
    );

    final Container _textFieldPassword = _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerPassword,
      ContentTexts.password,
      Icons.lock,
      (input) {
        _signInProviders.passwordSignIn = input.trim();
      },
      isRegistered: true,
      isPasswordSignIn: true,
    );

    final Form _signInForm = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _textFieldEmail,
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _textFieldPassword,
        ],
      ),
    );

    final Row _forgotText = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ContentTexts.forgotPasswordRoute);
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

    final Material _signInWithEmailAndPasswordButton =
        _actionButtonWidget.createActionButtonWidget(
      context,
      ContentColors.orange,
      Colors.white,
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
            await _signIn();
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

    final Row _signUpText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
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
                    Navigator.pushNamed(context, ContentTexts.signUpRoute);
                  },
              ),
            ],
          ),
        ),
      ],
    );

    final Row _orText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
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

    final Material _signInWithFacebookButton =
        _actionButtonWidget.createActionButtonWidget(
      context,
      ContentColors.facebook,
      Colors.white,
      ContentTexts.signInWithFacebook,
      () async {
        try {
          _appProviders.isLoading = true;
          await _facebookService.signInWithFacebook();
          await _signIn(isSignInWithFacebook: true);
        } catch (error) {
          _appProviders.isLoading = false;
          _alertDialogWidget.createAlertDialogWidget(
            context,
            ContentTexts.oops,
            error,
            ContentTexts.ok,
          );
        }
      },
      isFacebook: true,
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
            onWillPop: () async => _exitApp(),
            child: Scaffold(
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
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
                          _signInWithEmailAndPasswordButton,
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
                          _signInWithFacebookButton,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
