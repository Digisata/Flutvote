import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoProfileWidget {
  CircleAvatar createPhotoProfileWidget(
    double _radius,
    _size,
  ) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: _radius,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl:
            'https://sairajfilmsproduction.com/application/assets/images/nopic.jpg',
        progressIndicatorBuilder: (context, url, download) =>
            CircularProgressIndicator(
          value: download.progress,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageBuilder: (context, imageProvider) => Container(
          height: _size,
          width: _size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
