import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class IntroductionRoute extends StatefulWidget {
  @override
  _IntroductionRouteState createState() => _IntroductionRouteState();
}

class _IntroductionRouteState extends State<IntroductionRoute> {
  final TextEditingController _textEditingControllerDisplayName =
          TextEditingController(),
      _textEditingControllerUsername = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<IntroductionScreenState> _introductionKey =
      GlobalKey<IntroductionScreenState>();
  final IntroductionWidget _introductionWidget = IntroductionWidget();
  final PhotoProfileWidget _photoProfileWidget = PhotoProfileWidget();
  final TextFieldWidget _textFieldWidget = TextFieldWidget();
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();
  final BottomSheetWidget _bottomSheetWidget = BottomSheetWidget();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final UserProfileProviders _userProfileProviders =
        Provider.of<UserProfileProviders>(context);
    final HiveProviders _hiveProviders = Provider.of<HiveProviders>(context);
    final EditProfileProviders _editProfileProviders =
        Provider.of<EditProfileProviders>(context);

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

    final Hero _photoProfile = Hero(
      tag: ContentTexts.photoProfileTag,
      child: GestureDetector(
        onTap: () {
          _bottomSheetWidget.createBottomSheetWidget(
            context,
            _editProfileProviders,
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _photoProfileWidget.createPhotoProfileWidget(
              ContentSizes.height(context) * 0.06,
              ContentSizes.height(context) * 0.12,
              isSetupProfile: true,
              hiveProviders: _hiveProviders,
              editProfileProviders: _editProfileProviders,
            ),
            CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.5),
              radius: ContentSizes.height(context) * 0.06,
            ),
            Icon(
              Icons.image,
              color: Colors.white,
              size: 35.0,
            ),
          ],
        ),
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
                      bodyWidget: Column(
                        children: <Widget>[
                          _setupProfileText,
                          SizedBox(
                            height: ContentSizes.height(context) * 0.02,
                          ),
                          _descriptionText,
                          SizedBox(
                            height: ContentSizes.height(context) * 0.05,
                          ),
                          _photoProfile,
                          SizedBox(
                            height: ContentSizes.height(context) * 0.05,
                          ),
                          _setupProfileForm,
                        ],
                      ),
                    ),
                  ],
                  onDone: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if (_editProfileProviders.image != null) {
                        try {
                          _appProviders.isLoading = true;
                          if (!await _firestoreService.isUsernameExist(
                              _userProfileProviders.username)) {
                            final String _imageName =
                                basename(_editProfileProviders.image.path);
                            final String _photoUrl =
                                await _firebaseStorageService
                                    .getPhotoProfileUrl(
                              _editProfileProviders.image,
                              _imageName,
                            );
                            _userProfileProviders.photoUrl = _photoUrl;
                            _editProfileProviders.image = null;
                            await _firestoreService.updatePhotoUrl(_photoUrl);
                            await _firestoreService.updateDisplayName(
                                _userProfileProviders.displayName);
                            await _firestoreService
                                .updateUsername(_userProfileProviders.username);
                            await _firestoreService
                                .updateIsSetupCompleted(true);
                            await _firestoreService.fetchUserData();
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
                          } else {
                            _appProviders.isLoading = false;
                            _alertDialogWidget.createAlertDialogWidget(
                              context,
                              ContentTexts.oops,
                              ContentTexts.usernameExistDescription,
                              ContentTexts.ok,
                            );
                          }
                        } catch (error) {
                          _appProviders.isLoading = false;
                          _alertDialogWidget.createAlertDialogWidget(
                            context,
                            ContentTexts.oops,
                            ContentTexts.errorSetupUserProfile,
                            ContentTexts.ok,
                          );
                        }
                      } else {
                        _alertDialogWidget.createAlertDialogWidget(
                          context,
                          ContentTexts.pickPhotoFirst,
                          ContentTexts.pickPhotoDescription,
                          ContentTexts.ok,
                        );
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
