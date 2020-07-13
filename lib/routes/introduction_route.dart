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

  @override
  Widget build(BuildContext context) {
    final IntroductionWidget _introductionSearchWidget = IntroductionWidget(
      context,
      'assets/ilustrators/search_ilustrator.png',
      ContentTexts.searchIntroduction,
      ContentTexts.searchDescriptionIntroduction,
    );

    final IntroductionWidget _introductionInputWidget = IntroductionWidget(
      context,
      'assets/ilustrators/input_ilustrator.png',
      ContentTexts.inputIntroduction,
      ContentTexts.inputDescriptionIntroduction,
    );

    final IntroductionWidget _introductionVoteWidget = IntroductionWidget(
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
              bodyWidget: _introductionSearchWidget.createIntroductionWidget(),
            ),
            PageViewModel(
              title: '',
              bodyWidget: _introductionInputWidget.createIntroductionWidget(),
            ),
            PageViewModel(
              title: '',
              bodyWidget: _introductionVoteWidget.createIntroductionWidget(),
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
                  color: ColorPalettes.orange,
                  fontSize: ContentSizes.dp20(context),
                ),
          ),
          next: Icon(
            Icons.arrow_forward,
            color: ColorPalettes.orange,
            size: ContentSizes.width(context) * 0.07,
          ),
          done: Text(
            ContentTexts.done,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: Theme.of(context).textTheme.headline1.copyWith(
                  color: ColorPalettes.orange,
                  fontSize: ContentSizes.dp20(context),
                ),
          ),
          dotsDecorator: DotsDecorator(
            size: Size(
              ContentSizes.width(context) * 0.02,
              ContentSizes.height(context) * 0.01,
            ),
            color: ColorPalettes.backgroundDarkGrey,
            activeSize: Size(
              ContentSizes.width(context) * 0.05,
              ContentSizes.height(context) * 0.01,
            ),
            activeColor: ColorPalettes.orange,
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
