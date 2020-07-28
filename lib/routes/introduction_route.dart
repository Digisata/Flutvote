import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class IntroductionRoute extends StatefulWidget {
  @override
  _IntroductionRouteState createState() => _IntroductionRouteState();
}

class _IntroductionRouteState extends State<IntroductionRoute> {
  final TextEditingController _textEditingControllerDisplayName =
          TextEditingController(),
      _textEditingControllerUsername = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<IntroductionScreenState> _introductionKey =
      GlobalKey<IntroductionScreenState>();
  final IntroductionWidget _introductionWidget = IntroductionWidget();
  final TextFieldWidget _textFieldWidget = TextFieldWidget();
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final UserProfileProviders _userProfileProviders =
        Provider.of<UserProfileProviders>(context);

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

    final Text _setupProfileText = Text(
      ContentTexts.setupProfile,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Text _descriptionText = Text(
      ContentTexts.setupProfileDescription,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline2.copyWith(
            fontSize: ContentSizes.dp18(context),
          ),
    );

    final Container _textFieldDisplayName =
        _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerDisplayName,
      ContentTexts.displayName,
      Icons.account_circle,
      (input) {
        _userProfileProviders.displayName = input.trim();
      },
      isSetupProfile: true,
      isDisplayName: true,
    );

    final Container _textFieldUsername = _textFieldWidget.createTextFieldWidget(
      context,
      _textEditingControllerUsername,
      ContentTexts.username,
      Icons.alternate_email,
      (input) {
        _userProfileProviders.username = input.trim();
      },
      isSetupProfile: true,
      isUsername: true,
    );

    final Form _setupProfileForm = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _setupProfileText,
          SizedBox(
            height: ContentSizes.height(context) * 0.02,
          ),
          _descriptionText,
          SizedBox(
            height: ContentSizes.height(context) * 0.05,
          ),
          _textFieldDisplayName,
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _textFieldUsername,
        ],
      ),
    );

    final Center _introductionSearch =
        _introductionWidget.createIntroductionWidget(
      context,
      'assets/ilustrators/search_ilustrator.png',
      ContentTexts.searchIntroduction,
      ContentTexts.searchDescriptionIntroduction,
    );

    final Center _introductionInput =
        _introductionWidget.createIntroductionWidget(
      context,
      'assets/ilustrators/input_ilustrator.png',
      ContentTexts.inputIntroduction,
      ContentTexts.inputDescriptionIntroduction,
    );

    final Center _introductionVote =
        _introductionWidget.createIntroductionWidget(
      context,
      'assets/ilustrators/vote_ilustrator.png',
      ContentTexts.voteIntroduction,
      ContentTexts.voteDescriptionIntroduction,
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
                child: IntroductionScreen(
                  key: _introductionKey,
                  pages: [
                    PageViewModel(
                      title: '',
                      bodyWidget: _introductionSearch,
                    ),
                    PageViewModel(
                      title: '',
                      bodyWidget: _introductionInput,
                    ),
                    PageViewModel(
                      title: '',
                      bodyWidget: _introductionVote,
                    ),
                    PageViewModel(
                      title: '',
                      bodyWidget: _setupProfileForm,
                    ),
                  ],
                  onDone: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      try {
                        _appProviders.isLoading = true;
                        AppProviders.setUserModel = UserModel(
                          username: _userProfileProviders.username,
                          displayName: _userProfileProviders.displayName,
                          isSetupCompleted: true,
                        );
                        await _firestoreService.updateUsernameAndDisplayName(
                            AppProviders.userModel);
                        await _firestoreService
                            .updateIsSetupCompleted(AppProviders.userModel);
                        await HiveProviders.syncUserData();
                        _appProviders.isLoading = false;
                        _alertDialogWidget.createAlertDialogWidget(
                          context,
                          ContentTexts.yeay,
                          ContentTexts.setupProfileSuccessfully,
                          ContentTexts.homePage,
                          routeName: ContentTexts.homeRoute,
                          isOnlyCancelButton: false,
                          isOnlyOkButton: true,
                        );
                      } catch (error) {
                        throw 'set up profile error: $error';
                      }
                    }
                  },
                  isProgress: true,
                  showSkipButton: true,
                  showNextButton: true,
                  skipFlex: 0,
                  nextFlex: 0,
                  skip: Text(
                    ContentTexts.skip,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          color: ContentColors.orange,
                          fontSize: ContentSizes.dp20(context),
                        ),
                  ),
                  next: Icon(
                    Icons.arrow_forward,
                    color: ContentColors.orange,
                    size: ContentSizes.width(context) * 0.07,
                  ),
                  done: Text(
                    ContentTexts.done,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          color: ContentColors.orange,
                          fontSize: ContentSizes.dp20(context),
                        ),
                  ),
                  dotsDecorator: DotsDecorator(
                    size: Size(
                      ContentSizes.width(context) * 0.02,
                      ContentSizes.height(context) * 0.01,
                    ),
                    color: ContentColors.backgroundDarkGrey,
                    activeSize: Size(
                      ContentSizes.width(context) * 0.05,
                      ContentSizes.height(context) * 0.01,
                    ),
                    activeColor: ContentColors.orange,
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
