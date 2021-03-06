import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SettingRoute extends StatelessWidget {
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();
  final BackButtonWidget _backButtonWidget = BackButtonWidget();
  final PhotoProfileWidget _photoProfileWidget = PhotoProfileWidget();
  final SettingItemWidget _settingItemWidget = SettingItemWidget();
  final ActionButtonWidget _actionButtonWidget = ActionButtonWidget();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final HiveProviders _hiveProviders = Provider.of<HiveProviders>(context);
    final HomeProviders _homeProviders = Provider.of<HomeProviders>(context);
    final MyPostsProviders _myPostsProviders =
        Provider.of<MyPostsProviders>(context);
    final MyVotedProviders _myVotedProviders =
        Provider.of<MyVotedProviders>(context);

    _onBackButtonPressed() {
      Navigator.pop(context, true);
    }

    final IconButton _backButton = _backButtonWidget.createBackButton(
      context,
      ContentTexts.backToHomeRoute,
      () {
        _onBackButtonPressed();
      },
    );

    final Hero _photoProfile = Hero(
      tag: ContentTexts.photoProfileTag,
      child: _photoProfileWidget.createPhotoProfileWidget(
        ContentSizes.height(context) * 0.06,
        ContentSizes.height(context) * 0.12,
        hiveProviders: _hiveProviders,
      ),
    );

    final Text _displayNameText = Text(
      _hiveProviders.displayName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Text _userNameText = Text(
      '@${_hiveProviders.username}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline2.copyWith(
            fontSize: ContentSizes.dp14(context),
          ),
    );

    final GestureDetector _settingItemEditProfile =
        _settingItemWidget.createSettingItemWidget(
      context,
      ContentTexts.editProfile,
      () {
        Navigator.pushNamed(context, ContentTexts.editProfileRoute);
      },
    );

    final GestureDetector _settingItemChangePassword =
        _settingItemWidget.createSettingItemWidget(
      context,
      ContentTexts.changePassword,
      () {
        Navigator.pushNamed(context, ContentTexts.changePasswordRoute);
      },
    );

    final Expanded _settingList = Expanded(
      child: Column(
        children: <Widget>[
          _settingItemEditProfile,
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _settingItemChangePassword,
        ],
      ),
    );

    final Material _signOutButtonWidget =
        _actionButtonWidget.createActionButtonWidget(
      context,
      ContentColors.backgroundDarkGrey,
      ContentColors.grey,
      ContentTexts.signOut,
      () {
        _alertDialogWidget.createAlertDialogWidget(
          context,
          ContentTexts.signOut,
          ContentTexts.signOutConfirmation,
          ContentTexts.signOut,
          isOnlyCancelButton: false,
          isSignOut: true,
          appProviders: _appProviders,
          homeProviders: _homeProviders,
          myPostsProviders: _myPostsProviders,
          myVotedProviders: _myVotedProviders,
        );
      },
    );

    final Row _appVersionText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Version ${_hiveProviders.appVersion}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize: ContentSizes.dp12(context),
              ),
        ),
      ],
    );

    return WillPopScope(
      onWillPop: () async => _onBackButtonPressed(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: _backButton,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            ContentSizes.width(context) * 0.05,
            ContentSizes.width(context) * 0.01,
            ContentSizes.width(context) * 0.05,
            ContentSizes.width(context) * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _photoProfile,
              SizedBox(
                height: ContentSizes.height(context) * 0.01,
              ),
              _displayNameText,
              _userNameText,
              SizedBox(
                height: ContentSizes.height(context) * 0.05,
              ),
              _settingList,
              SizedBox(
                height: ContentSizes.height(context) * 0.01,
              ),
              _appVersionText,
              SizedBox(
                height: ContentSizes.height(context) * 0.01,
              ),
              _signOutButtonWidget,
            ],
          ),
        ),
      ),
    );
  }
}
