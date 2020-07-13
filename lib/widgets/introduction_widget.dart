import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';

class IntroductionWidget {
  final BuildContext _context;
  final String _image, _title, _description;

  IntroductionWidget(
    this._context,
    this._image,
    this._title,
    this._description,
  );

  Center createIntroductionWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // TODO FADE IN IMAGE
          Image.asset(
            _image,
            height: ContentSizes.height(_context) * 0.5,
            width: ContentSizes.width(_context),
          ),
          SizedBox(
            height: ContentSizes.height(_context) * 0.02,
          ),
          Text(
            _title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: Theme.of(_context).textTheme.headline1.copyWith(
                  fontSize: ContentSizes.dp24(_context),
                ),
          ),
          SizedBox(
            height: ContentSizes.height(_context) * 0.02,
          ),
          Text(
            _description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: Theme.of(_context).textTheme.headline2.copyWith(
                  fontSize: ContentSizes.dp18(_context),
                ),
          ),
        ],
      ),
    );
  }
}
