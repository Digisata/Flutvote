import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';

class PhotoProfileWidget {
  CircleAvatar createPhotoProfileWidget(
    double _radius,
    _size, {
    bool isDetailPost = false,
    isSetupProfile = false,
    isEditProfile = false,
    String photoUrl,
    HiveProviders hiveProviders,
    EditProfileProviders editProfileProviders,
  }) {
    return CircleAvatar(
      backgroundColor: ContentColors.transparent,
      radius: _radius,
      child: (isSetupProfile || isEditProfile) &&
              editProfileProviders.image != null
          ? Container(
              height: _size,
              width: _size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ContentColors.transparent,
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: FileImage(
                    editProfileProviders.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: isDetailPost ? photoUrl : hiveProviders.photoUrl,
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
                  color: ContentColors.transparent,
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
    );
  }
}
