import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';

class ActionButtonWidget {
  Material createActionButtonWidget(
    BuildContext _context,
    Color _backgroundColor,
    Color _textColor,
    String _text,
    Function _function, {
    bool isFacebook = false,
    isFilter = false,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      color: _backgroundColor,
      child: MaterialButton(
        height: ContentSizes.height(_context) * 0.07,
        minWidth: ContentSizes.width(_context),
        onPressed: _function,
        padding: EdgeInsets.fromLTRB(
          ContentSizes.width(_context) * 0.05,
          ContentSizes.height(_context) * 0.01,
          ContentSizes.width(_context) * 0.05,
          ContentSizes.height(_context) * 0.01,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            !isFacebook
                ? Container()
                : Image.asset(
                    "assets/logos/facebook_logo.png",
                    height: ContentSizes.height(_context) * 0.04,
                    width: ContentSizes.height(_context) * 0.04,
                    alignment: Alignment.center,
                  ),
            !isFacebook
                ? Container()
                : SizedBox(
                    width: ContentSizes.height(_context) * 0.01,
                  ),
            Text(
              _text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: Theme.of(_context).textTheme.headline2.copyWith(
                    color: _textColor,
                    fontSize: isFilter
                        ? ContentSizes.dp16(_context)
                        : ContentSizes.dp18(_context),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
