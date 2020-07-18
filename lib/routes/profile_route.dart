import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ProfileRoute extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();
  final Box _userData = Hive.box('userData');

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of(context, listen: false);
    final AlertDialogWidget _alertDialogWidget = AlertDialogWidget(context);

    final BackButtonWidget _backButtonWidget = BackButtonWidget(
      context,
      ContentTexts.backToHomeRoute,
      () {
        Navigator.pop(context);
      },
    );

    final PhotoProfileWidget _photoProfileWidget = PhotoProfileWidget(
      ContentSizes.height(context) * 0.06,
      ContentSizes.height(context) * 0.12,
    );

    final SettingItemWidget _settingItemEditProfileWidget = SettingItemWidget(
      context,
      ContentTexts.editProfile,
      () {
        Navigator.pushNamed(context, '/editProfileRoute');
      },
    );

    final SettingItemWidget _settingItemChangePasswordWidget =
        SettingItemWidget(
      context,
      ContentTexts.changePassword,
      () {
        Navigator.pushNamed(context, '/changePasswordRoute');
      },
    );

    final GestureDetector _photoProfile = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profileRoute');
      },
      child: _photoProfileWidget.createPhotoProfileWidget(),
    );

    final Text _displayNameText = Text(
      _userData.get('displayName'),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Text _userNameText = Text(
      '@${_userData.get('username')}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline2.copyWith(
            fontSize: ContentSizes.dp14(context),
          ),
    );

    final Expanded _settingList = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _settingItemEditProfileWidget.createSettingItemWidget(),
          SizedBox(
            height: ContentSizes.height(context) * 0.03,
          ),
          _settingItemChangePasswordWidget.createSettingItemWidget(),
        ],
      ),
    );

    final ActionButtonWidget _signOutButtonWidget = ActionButtonWidget(
      context,
      ContentColors.grey,
      ContentTexts.signOut,
      () async {
        try {
          await _firebaseService.signOut();
          _alertDialogWidget.createAlertDialogWidget(
            ContentTexts.missYou,
            ContentTexts.areYouSure,
            ContentTexts.yes,
            isSignOut: true,
          );
        } catch (error) {
          throw 'signout error: $error';
        }
      },
    );

    final Row _appVersionText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Version ${_appProviders.appVersion}',
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

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: _backButtonWidget.createBackButton(),
        backgroundColor: ContentColors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(ContentSizes.width(context) * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            _signOutButtonWidget.createActionButtonWidget(),
          ],
        ),
      ),
    );
  }
}
