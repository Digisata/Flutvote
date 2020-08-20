import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpRoute extends StatelessWidget {
  final TextEditingController _textEditingControllerEmail =
          TextEditingController(),
      _textEditingControllerPassword = TextEditingController(),
      _textEditingControllerRepeatPassword = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();
  final BackButtonWidget _backButtonWidget = BackButtonWidget();
  final TextFieldWidget _textFieldWidget = TextFieldWidget();
  final ActionButtonWidget _actionButtonWidget = ActionButtonWidget();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final SignUpProviders _signUpProviders =
        Provider.of<SignUpProviders>(context);

    _onBackButtonPressed() {
      if (_signUpProviders.isPasswordSignUpVisible) {
        _signUpProviders.isPasswordSignUpVisible = false;
      }
      if (_signUpProviders.isRepeatPasswordSignUpVisible) {
        _signUpProviders.isRepeatPasswordSignUpVisible = false;
      }
      if (_signUpProviders.isTermsAndConditionsAccepted) {
        _signUpProviders.isTermsAndConditionsAccepted = false;
      }
      Navigator.pop(context, true);
    }

    final IconButton _backButton = _backButtonWidget.createBackButton(
      context,
      ContentTexts.backToSignInRoute,
      () {
        _onBackButtonPressed();
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

    final Container _textFieldEmail = _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerEmail,
      ContentTexts.email,
      Icons.email,
      (input) {
        _signUpProviders.emailSignUp = input.trim();
      },
      isEmail: true,
    );

    final Container _textFieldPassword = _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerPassword,
      ContentTexts.password,
      Icons.lock,
      (input) {
        _signUpProviders.passwordSignUp = input.trim();
      },
      isSignUp: true,
      isPasswordSignUp: true,
    );

    final Container _textFieldRepeatPassword =
        _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerRepeatPassword,
      ContentTexts.repeatPassword,
      Icons.lock,
      (input) {
        _signUpProviders.repeatPasswordSignUp = input.trim();
      },
      isSignUp: true,
      isRepeatPasswordSignUp: true,
    );

    final Form _signUpForm = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _textFieldEmail,
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _textFieldPassword,
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _textFieldRepeatPassword,
        ],
      ),
    );

    final Checkbox _termsAndConditionsCheckbox = Checkbox(
      value: _signUpProviders.isTermsAndConditionsAccepted,
      activeColor: ContentColors.orange,
      onChanged: (value) {
        _signUpProviders.isTermsAndConditionsAccepted = value;
      },
    );

    final Row _termsAndConditionsText = Row(
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
                text: ContentTexts.acceptOur,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: ContentSizes.dp12(context),
                    ),
              ),
              TextSpan(
                text: ContentTexts.termsAndConditions,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: ContentColors.orange,
                      fontSize: ContentSizes.dp12(context),
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    const String _url = ContentTexts.defaultPrivacyAndPolicyUrl;
                    _appProviders.isLoading = true;
                    try {
                      if (await canLaunch(_url)) {
                        _appProviders.isLoading = false;
                        await launch(_url);
                      }
                    } catch (error) {
                      _appProviders.isLoading = false;
                      _alertDialogWidget.createAlertDialogWidget(
                        context,
                        ContentTexts.oops,
                        ContentTexts.errorLaunchUrl,
                        ContentTexts.ok,
                      );
                    }
                  },
              ),
            ],
          ),
        ),
      ],
    );

    final Row _termsAndConditions = Row(
      children: <Widget>[
        _termsAndConditionsCheckbox,
        SizedBox(
          width: ContentSizes.width(context) * 0.01,
        ),
        _termsAndConditionsText,
      ],
    );

    final Material _signUpEmailAndPaswordButton =
        _actionButtonWidget.createActionButtonWidget(
      context,
      ContentColors.orange,
      ContentColors.white,
      ContentTexts.signUp,
      () async {
        _signUpProviders.passwordSignUp =
            _textEditingControllerPassword.text.trim();
        _signUpProviders.repeatPasswordSignUp =
            _textEditingControllerRepeatPassword.text.trim();
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          if (_signUpProviders.isTermsAndConditionsAccepted) {
            try {
              _appProviders.isLoading = true;
              await _firebaseService.signUpWithEmailAndPassword(
                _signUpProviders.emailSignUp,
                _signUpProviders.passwordSignUp,
              );
              _appProviders.isLoading = false;
              _alertDialogWidget.createAlertDialogWidget(
                context,
                ContentTexts.yeay,
                'We sent an email verification to ${_signUpProviders.emailSignUp}, please confirm that',
                ContentTexts.signIn,
                isOnlyCancelButton: false,
                isOnlyOkButton: true,
                isSignUp: true,
                signUpProviders: _signUpProviders,
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
          } else {
            _alertDialogWidget.createAlertDialogWidget(
              context,
              ContentTexts.oops,
              ContentTexts.pleaseAccept,
              ContentTexts.ok,
            );
          }
        }
      },
    );

    final Row _signInText = Row(
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
                text: ContentTexts.alreadyHaveAccount,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: ContentSizes.dp12(context),
                    ),
              ),
              TextSpan(
                text: ContentTexts.signIn,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: ContentColors.orange,
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
                      _signUpText,
                      SizedBox(
                        height: ContentSizes.height(context) * 0.05,
                      ),
                      _signUpForm,
                      SizedBox(
                        height: ContentSizes.height(context) * 0.025,
                      ),
                      _termsAndConditions,
                      SizedBox(height: ContentSizes.height(context) * 0.025),
                      _signUpEmailAndPaswordButton,
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
