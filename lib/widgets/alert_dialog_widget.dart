import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class AlertDialogWidget {
  final FirebaseService _firebaseService = FirebaseService();

  createAlertDialogWidget(
    BuildContext _context,
    String _title,
    String _description,
    String _textButton, {
    String routeName = '/signInRoute',
    bool isOnlyCancelButton = true,
    isOnlyOkButton = false,
    isSignUp = false,
    isSignOut = false,
    isChangePassword = false,
  }) {
    final AppProviders _appProviders = AppProviders();
    final SignUpProviders _signUpProviders = SignUpProviders();
    final ChangePasswordProviders _changePasswordProviders =
        ChangePasswordProviders();

    showDialog(
      barrierDismissible: false,
      context: _context,
      builder: (_) => NetworkGiffyDialog(
        image: CachedNetworkImage(
          alignment: Alignment.center,
          fit: BoxFit.cover,
          fadeInCurve: Curves.bounceIn,
          fadeOutCurve: Curves.bounceOut,
          fadeInDuration: Duration(milliseconds: 500),
          fadeOutDuration: Duration(milliseconds: 500),
          imageUrl:
              'https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF\'s/gif14.gif',
          progressIndicatorBuilder: (context, url, download) => Center(
            child: Container(
              width: ContentSizes.height(context) * 0.1,
              height: ContentSizes.height(context) * 0.1,
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                value: download.progress,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: Container(
              child: Icon(
                Icons.error,
                color: ContentColors.orange,
                size: ContentSizes.height(context) * 0.15,
              ),
            ),
          ),
        ),
        cornerRadius: 20.0,
        onlyCancelButton: isOnlyCancelButton,
        onlyOkButton: isOnlyOkButton,
        buttonCancelColor: isOnlyCancelButton
            ? ContentColors.orange
            : ContentColors.backgroundGrey,
        buttonOkColor: ContentColors.orange,
        buttonRadius: 20.0,
        buttonCancelText: Text(
          isOnlyCancelButton ? ContentTexts.ok : ContentTexts.cancel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: Theme.of(_context).textTheme.headline1.copyWith(
                color: isOnlyCancelButton
                    ? ContentColors.white
                    : ContentColors.grey,
                fontSize: ContentSizes.dp16(_context),
              ),
        ),
        buttonOkText: Text(
          _textButton,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: Theme.of(_context).textTheme.headline1.copyWith(
                color: ContentColors.white,
                fontSize: ContentSizes.dp16(_context),
              ),
        ),
        title: Text(
          _title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: Theme.of(_context).textTheme.headline1.copyWith(
                fontSize: ContentSizes.dp24(_context),
              ),
        ),
        description: Text(
          _description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: Theme.of(_context).textTheme.headline2.copyWith(
                fontSize: ContentSizes.dp18(_context),
              ),
        ),
        onCancelButtonPressed: () {
          Navigator.pop(_context);
        },
        onOkButtonPressed: () async {
          if (isSignUp) {
            _signUpProviders.isPasswordSignUpVisible = false;
            _signUpProviders.isRepeatPasswordSignUpVisible = false;
          } else if (isSignOut) {
            if (isChangePassword) {
              _changePasswordProviders.isOldPasswordChangeVisible = false;
              _changePasswordProviders.isNewPasswordChangeVisible = false;
              _changePasswordProviders.isNewRepeatPasswordChangeVisible = false;
            }
            try {
              _appProviders.isLoading = true;
              await _firebaseService.signOut();
              _appProviders.isLoading = false;
            } catch (error) {
              throw 'Sign out error: $error';
            }
          }
          Navigator.pushReplacementNamed(_context, routeName);
        },
      ),
    );
  }
}
