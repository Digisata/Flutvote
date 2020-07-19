import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';

class ActionButtonWidget {
  Material createActionButtonWidget(
    BuildContext _context,
    Color _color,
    String _text,
    Function _validate, {
    bool isFacebook = false,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      color: _color,
      child: MaterialButton(
        height: ContentSizes.height(_context) * 0.07,
        minWidth: ContentSizes.width(_context),
        onPressed: () async {
          await _validate();
        },
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            !isFacebook
                ? Container()
                : Image.asset(
                    "assets/logos/facebook_logo.png",
                    width: ContentSizes.height(_context) * 0.04,
                    height: ContentSizes.height(_context) * 0.04,
                    alignment: Alignment.center,
                  ),
            SizedBox(
              width: ContentSizes.height(_context) * 0.01,
            ),
            Text(
              _text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: Theme.of(_context).textTheme.headline2.copyWith(
                    color: Colors.white,
                    fontSize: ContentSizes.dp18(_context),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
