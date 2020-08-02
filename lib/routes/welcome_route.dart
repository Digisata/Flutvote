import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';

class WelcomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Image _flutvoteLogo = Image.asset(
      'assets/logos/flutvote_logo.png',
      height: ContentSizes.height(context) * 0.3,
      width: ContentSizes.height(context) * 0.3,
    );

    final Text _welcomeText = Text(
      ContentTexts.welcome,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Text _descriptionText = Text(
      ContentTexts.welcomeDesciption,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline2.copyWith(
            fontSize: ContentSizes.dp18(context),
          ),
    );

    final GestureDetector _createAccountButton = GestureDetector(
      onTap: () {
        HiveProviders.setFirstOpened();
        Navigator.pushReplacementNamed(context, ContentTexts.signInRoute);
      },
      child: Container(
        height: ContentSizes.height(context) * 0.07,
        width: ContentSizes.width(context),
        padding: EdgeInsets.fromLTRB(
          ContentSizes.width(context) * 0.02,
          ContentSizes.height(context) * 0.01,
          ContentSizes.width(context) * 0.02,
          ContentSizes.height(context) * 0.01,
        ),
        decoration: BoxDecoration(
          color: ContentColors.orange,
          shape: BoxShape.rectangle,
        ),
        child: Text(
          ContentTexts.welcomeButton,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.headline1.copyWith(
                color: Colors.white,
                fontSize: ContentSizes.dp22(context),
              ),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  ContentSizes.width(context) * 0.05,
                  ContentSizes.height(context) * 0.15,
                  ContentSizes.width(context) * 0.05,
                  ContentSizes.height(context) * 0.15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _flutvoteLogo,
                    SizedBox(
                      height: ContentSizes.height(context) * 0.04,
                    ),
                    _welcomeText,
                    SizedBox(
                      height: ContentSizes.height(context) * 0.02,
                    ),
                    _descriptionText,
                  ],
                ),
              ),
              _createAccountButton,
            ],
          ),
        ),
      ),
    );
  }
}
