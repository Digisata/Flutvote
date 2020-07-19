import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoProfileWidget {
  Hero createPhotoProfileWidget(
    double _radius,
    _size,
  ) {
    return Hero(
      tag: 'photoProfile',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: _radius,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl:
              'https://avatars0.githubusercontent.com/u/30319634?s=400&u=0351d283b9e76d31e8bbd80e088b2c12618948c8&v=4',
          progressIndicatorBuilder: (context, url, download) =>
              CircularProgressIndicator(
            value: download.progress,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) => Container(
            width: _size,
            height: _size,
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
      ),
    );
  }
}
