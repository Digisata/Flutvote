import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';

class BackButtonWidget {
  IconButton createBackButton(
    BuildContext _context,
    String _tooltip,
    Function _function,
  ) {
    return IconButton(
      icon: Image.asset(
        'assets/buttons/back_button.png',
        height: ContentSizes.height(_context) * 0.03,
        width: ContentSizes.height(_context) * 0.03,
      ),
      onPressed: () {
        _function();
      },
      tooltip: _tooltip,
    );
  }
}
