import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:hive/hive.dart';

class ProfileRoute extends StatelessWidget {
  final Box _userData = Hive.box('userData');

  @override
  Widget build(BuildContext context) {
    final BackButtonWidget _backButtonWidget = BackButtonWidget(
      context,
      ContentTexts.backToSignInRoute,
      () {
        Navigator.pop(context);
      },
    );

    final CircleAvatar _profileIcon = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: ContentSizes.height(context) * 0.025,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl:
            'https://avatars0.githubusercontent.com/u/30319634?s=400&u=0351d283b9e76d31e8bbd80e088b2c12618948c8&v=4',
        progressIndicatorBuilder: (context, url, download) =>
            CircularProgressIndicator(
          value: download.progress,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageBuilder: (context, imageProvider) => Container(
          width: ContentSizes.height(context) * 0.5,
          height: ContentSizes.height(context) * 0.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    final Text _displayNameText = Text(
      _userData.getAt(0).displayName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Text _userNameText = Text(
      _userData.getAt(0).userName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline2.copyWith(
            fontSize: ContentSizes.dp12(context),
          ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: _backButtonWidget.createBackButton(),
        backgroundColor: ContentColors.white,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          ContentSizes.width(context) * 0.05,
          ContentSizes.height(context) * 0.05,
          ContentSizes.width(context) * 0.05,
          0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _profileIcon,
            SizedBox(
              height: ContentSizes.height(context) * 0.02,
            ),
            _displayNameText,
            SizedBox(
              height: ContentSizes.height(context) * 0.01,
            ),
            _userNameText,
          ],
        ),
      ),
    );
  }
}
