import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';

class IntroductionWidget {
  Center createIntroductionWidget(
    BuildContext _context,
    String _image,
    _title,
    _description,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            _image,
            height: ContentSizes.height(_context) * 0.5,
            width: ContentSizes.width(_context),
            alignment: Alignment.center,
            fit: BoxFit.cover,
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
