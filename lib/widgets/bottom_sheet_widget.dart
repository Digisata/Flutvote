import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetWidget {
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();

  createBottomSheetWidget(
    BuildContext _context,
    EditProfileProviders _editProfileProviders,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: _context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          height: ContentSizes.height(context) * 0.15,
          width: ContentSizes.width(context),
          padding: EdgeInsets.fromLTRB(
            ContentSizes.width(context) * 0.05,
            ContentSizes.width(context) * 0.01,
            ContentSizes.width(context) * 0.05,
            ContentSizes.width(context) * 0.01,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(
                  ContentTexts.gallery,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: ContentColors.darkGrey,
                        fontSize: ContentSizes.dp18(context),
                      ),
                ),
                onTap: () async {
                  try {
                    final PickedFile _pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    final File _image = File(_pickedFile.path);
                    _editProfileProviders.image = _image;
                    Navigator.pop(context);
                  } catch (error) {
                    _alertDialogWidget.createAlertDialogWidget(
                      context,
                      ContentTexts.oops,
                      ContentTexts.errorGetImageFromGallery,
                      ContentTexts.ok,
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text(
                  ContentTexts.camera,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: ContentColors.darkGrey,
                        fontSize: ContentSizes.dp18(context),
                      ),
                ),
                onTap: () async {
                  try {
                    final PickedFile _pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    final File _image = File(_pickedFile.path);
                    _editProfileProviders.image = _image;
                    Navigator.pop(context);
                  } catch (error) {
                    _alertDialogWidget.createAlertDialogWidget(
                      context,
                      ContentTexts.oops,
                      ContentTexts.errorGetImageFromCamera,
                      ContentTexts.ok,
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
