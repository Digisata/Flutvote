import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';

class SettingItemWidget {
  GestureDetector createSettingItemWidget(
    BuildContext _context,
    String _title,
    Function _function,
  ) {
    return GestureDetector(
      onTap: _function,
      child: Container(
        padding: EdgeInsets.all(
          ContentSizes.height(_context) * 0.02,
        ),
        margin: EdgeInsets.only(
          bottom: ContentSizes.height(_context) * 0.001,
        ),
        height: ContentSizes.height(_context) * 0.07,
        width: ContentSizes.width(_context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: ContentColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: Theme.of(_context).textTheme.headline2.copyWith(
                    fontSize: ContentSizes.dp18(_context),
                  ),
            ),
            Image.asset(
              'assets/buttons/right_arrow_button.png',
              height: ContentSizes.height(_context) * 0.015,
              width: ContentSizes.height(_context) * 0.015,
            ),
          ],
        ),
      ),
    );
  }
}
