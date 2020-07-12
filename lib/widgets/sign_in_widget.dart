import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';

class SignInWidget {
  final BuildContext _context;
  final Color _color;
  final String _text;
  final Function _function;

  SignInWidget(this._context, this._color, this._text, this._function);

  Material createSignInWidget() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      color: _color,
      child: MaterialButton(
        height: ContentSizes.height(_context) * 0.07,
        minWidth: ContentSizes.width(_context),
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          _function();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _text,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
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
