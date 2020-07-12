import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';

class BackButtonWidget {
  final BuildContext _context;
  final Function _function;

  BackButtonWidget(this._context, this._function);

  IconButton createBackButton() {
    return IconButton(
      icon: Image.asset(
        'assets/buttons/back_button.png',
        height: ContentSizes.height(_context) * 0.03,
        width: ContentSizes.height(_context) * 0.03,
      ),
      onPressed: _function(),
    );
  }
}
