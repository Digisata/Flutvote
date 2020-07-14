import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';

class WelcomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                ContentSizes.width(context) * 0.1,
                ContentSizes.height(context) * 0.15,
                ContentSizes.width(context) * 0.1,
                ContentSizes.height(context) * 0.15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    'assets/logos/flutvote_logo.png',
                    height: ContentSizes.height(context) * 0.3,
                    width: ContentSizes.height(context) * 0.3,
                  ),
                  SizedBox(
                    height: ContentSizes.height(context) * 0.04,
                  ),
                  Text(
                    ContentTexts.welcome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: ContentSizes.dp24(context),
                        ),
                  ),
                  SizedBox(
                    height: ContentSizes.height(context) * 0.02,
                  ),
                  Text(
                    ContentTexts.welcomeDesciption,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: ContentSizes.dp18(context),
                        ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signInRoute');
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
                  color: ColorPalettes.orange,
                  shape: BoxShape.rectangle,
                ),
                child: Text(
                  ContentTexts.welcomeButton,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: ColorPalettes.white,
                        fontSize: ContentSizes.dp22(context),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
