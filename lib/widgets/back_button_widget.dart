import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';

class BackButtonWidget {
  IconButton createBackButton(
    BuildContext _context,
    String _tooltip,
    Function _function, {
    bool isVote = false,
  }) {
    return IconButton(
      icon: Image.asset(
        isVote
            ? 'assets/buttons/white_back_button.png'
            : 'assets/buttons/back_button.png',
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
