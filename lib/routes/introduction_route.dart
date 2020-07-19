import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionRoute extends StatefulWidget {
  @override
  _IntroductionRouteState createState() => _IntroductionRouteState();
}

class _IntroductionRouteState extends State<IntroductionRoute> {
  final GlobalKey<IntroductionScreenState> _introductionKey =
      GlobalKey<IntroductionScreenState>();
  final IntroductionWidget _introductionWidget = IntroductionWidget();

  @override
  Widget build(BuildContext context) {
    final Center _introductionSearch =
        _introductionWidget.createIntroductionWidget(
      context,
      'assets/ilustrators/search_ilustrator.png',
      ContentTexts.searchIntroduction,
      ContentTexts.searchDescriptionIntroduction,
    );

    final Center _introductionInputWidget =
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

    return Scaffold(
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
              bodyWidget: _introductionInputWidget,
            ),
            PageViewModel(
              title: '',
              bodyWidget: _introductionVote,
            ),
          ],
          onDone: () => Navigator.pushReplacementNamed(context, '/homeRoute'),
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
    );
  }
}
