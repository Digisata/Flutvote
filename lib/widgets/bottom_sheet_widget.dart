import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetWidget extends StatefulWidget {
  final EditProfileProviders editProfileProviders;
  final HistoryProviders historyProviders;
  final bool isProfile;

  BottomSheetWidget({
    this.editProfileProviders,
    this.historyProviders,
    this.isProfile = false,
  });

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState(
        editProfileProviders: this.editProfileProviders,
        historyProviders: this.historyProviders,
        isProfile: this.isProfile,
      );
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final EditProfileProviders editProfileProviders;
  final HistoryProviders historyProviders;
  final bool isProfile;
  final ActionButtonWidget _actionButtonWidget = ActionButtonWidget();

  _BottomSheetWidgetState({
    this.editProfileProviders,
    this.historyProviders,
    this.isProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      height: isProfile
          ? ContentSizes.height(context) * 0.16
          : ContentSizes.height(context) / 2,
      width: ContentSizes.width(context),
      child: isProfile
          ? Column(
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
                    final PickedFile _pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    final File _image = File(_pickedFile.path);
                    editProfileProviders.image = _image;
                    Navigator.pop(context);
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
                    final PickedFile _pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    final File _image = File(_pickedFile.path);
                    editProfileProviders.image = _image;
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          : Stack(
              alignment: Alignment.topCenter,
              textDirection: TextDirection.ltr,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        ContentSizes.width(context) * 0.05,
                        ContentSizes.width(context) * 0.02,
                        ContentSizes.width(context) * 0.05,
                        0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ContentColors.darkGrey,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: ContentSizes.height(context) * 0.005,
                            width: ContentSizes.width(context) * 0.1,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ContentSizes.height(context) * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: ContentSizes.width(context) * 0.05,
                        right: ContentSizes.width(context) * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ContentTexts.filter,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.ltr,
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      fontSize: ContentSizes.dp20(context),
                                    ),
                          ),
                          !historyProviders.isFiltered
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    historyProviders.resetMyPostsFilter();
                                    setState(() {});
                                  },
                                  child: Text(
                                    ContentTexts.reset,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    textDirection: TextDirection.ltr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(
                                          color: ContentColors.orange,
                                          fontSize: ContentSizes.dp18(context),
                                        ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ContentSizes.height(context) * 0.015,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: ContentSizes.height(context) * 0.015,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: ContentSizes.width(context) * 0.05,
                                right: ContentSizes.width(context) * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    ContentTexts.timeCreated,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    textDirection: TextDirection.ltr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .copyWith(
                                          fontSize: ContentSizes.dp18(context),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: ContentSizes.width(context) * 0.05,
                                right: ContentSizes.width(context) * 0.05,
                              ),
                              child: Container(
                                height: ContentSizes.height(context) * 0.05,
                                width: ContentSizes.width(context),
                                child: TimeCreatedWidget(
                                  historyProviders,
                                  () {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ContentSizes.height(context) * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: ContentSizes.width(context) * 0.05,
                                right: ContentSizes.width(context) * 0.05,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    ContentTexts.category,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    textDirection: TextDirection.ltr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .copyWith(
                                          fontSize: ContentSizes.dp18(context),
                                        ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      ContentTexts.seeAll,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      textDirection: TextDirection.ltr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          .copyWith(
                                            color: ContentColors.orange,
                                            fontSize:
                                                ContentSizes.dp16(context),
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                !historyProviders.isFiltered
                    ? Container()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.white,
                          height: ContentSizes.height(context) * 0.085,
                          width: ContentSizes.width(context),
                        ),
                      ),
                !historyProviders.isFiltered
                    ? Container()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            ContentSizes.width(context) * 0.05,
                            0,
                            ContentSizes.width(context) * 0.05,
                            ContentSizes.width(context) * 0.02,
                          ),
                          child: Container(
                            height: ContentSizes.height(context) * 0.06,
                            width: ContentSizes.width(context),
                            child: _actionButtonWidget.createActionButtonWidget(
                              context,
                              ContentColors.orange,
                              Colors.white,
                              'Show ${historyProviders.myPostSnapshots.length} posts',
                              () {
                                historyProviders.setMyPostSnapshots();
                                Navigator.pop(context);
                              },
                              isFilter: true,
                            ),
                          ),
                        ),
                      )
              ],
            ),
    );
  }
}
