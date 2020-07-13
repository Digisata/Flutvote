import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class AlertDialogWidget {
  final BuildContext _context;

  AlertDialogWidget(
    this._context,
  );

  createAlertDialogWidget(
    String _title,
    String _description,
    String _textButton,
  ) {
    showDialog(
      context: _context,
      builder: (_) => NetworkGiffyDialog(
        image: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl:
              'https://raw.githubusssercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF\'s/gif14.gif',
          progressIndicatorBuilder: (context, url, download) => Center(
            child: Container(
              width: ContentSizes.height(context) * 0.15,
              height: ContentSizes.height(context) * 0.15,
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                value: download.progress,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: Container(
              child: Icon(
                Icons.error,
                color: ColorPalettes.orange,
                size: ContentSizes.height(context) * 0.15,
              ),
            ),
          ),
        ),
        cornerRadius: 20.0,
        onlyOkButton: true,
        buttonOkColor: ColorPalettes.orange,
        buttonRadius: 20.0,
        buttonOkText: Text(
          _textButton,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: Theme.of(_context).textTheme.headline1.copyWith(
                color: ColorPalettes.white,
                fontSize: ContentSizes.dp16(_context),
              ),
        ),
        title: Text(
          _title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: Theme.of(_context).textTheme.headline1.copyWith(
                fontSize: ContentSizes.dp24(_context),
              ),
        ),
        description: Text(
          _description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: Theme.of(_context).textTheme.headline2.copyWith(
                fontSize: ContentSizes.dp18(_context),
              ),
        ),
        onOkButtonPressed: () {
          _title == 'Oops'
              ? Navigator.pop(_context)
              : Navigator.pushReplacementNamed(_context, '/signInRoute');
        },
      ),
    );
  }
}
