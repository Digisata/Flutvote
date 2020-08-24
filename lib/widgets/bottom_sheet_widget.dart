import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:collection/collection.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

class BottomSheetWidget extends StatefulWidget {
  final EditProfileProviders editProfileProviders;
  final MyPostsProviders myPostsProviders;
  final MyVotedProviders myVotedProviders;
  final bool isProfile, isMyPosts;

  BottomSheetWidget({
    this.editProfileProviders,
    this.myPostsProviders,
    this.myVotedProviders,
    this.isProfile = false,
    this.isMyPosts = false,
  });

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState(
        editProfileProviders: this.editProfileProviders,
        myPostsProviders: this.myPostsProviders,
        myVotedProviders: this.myVotedProviders,
        isProfile: this.isProfile,
        isMyPosts: this.isMyPosts,
      );
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final EditProfileProviders editProfileProviders;
  final MyPostsProviders myPostsProviders;
  final MyVotedProviders myVotedProviders;
  final bool isProfile, isMyPosts;
  final ActionButtonWidget _actionButtonWidget = ActionButtonWidget();
  final CreatedAtFilterWidget _createdAtFilterWidget = CreatedAtFilterWidget();
  final CategoryFilterWidget _categoryFilterWidget = CategoryFilterWidget();
  final Function unOrderedDeepEq = DeepCollectionEquality.unordered().equals;

  _BottomSheetWidgetState({
    this.editProfileProviders,
    this.myPostsProviders,
    this.myVotedProviders,
    this.isProfile = false,
    this.isMyPosts = false,
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
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    ContentSizes.width(context) * 0.05,
                    ContentSizes.width(context) * 0.02,
                    ContentSizes.width(context) * 0.05,
                    0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                      SizedBox(
                        height: ContentSizes.height(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          isMyPosts
                              ? myPostsProviders.isDefaultFilter
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        myPostsProviders.resetMyPostsFilter();
                                        myPostsProviders.setTotalPosts();
                                        myPostsProviders
                                            .isWaitingForGetTotalPosts = true;
                                        myPostsProviders
                                            .setOnGetTotalPostsCompleted = () {
                                          setState(() {});
                                        };
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
                                              color: ContentColors.darkOrange,
                                              fontSize:
                                                  ContentSizes.dp18(context),
                                            ),
                                      ),
                                    )
                              : myVotedProviders.isDefaultFilter
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        myVotedProviders.resetMyVotedFilter();
                                        myVotedProviders.setTotalVoted();
                                        myVotedProviders
                                            .isWaitingForGetTotalPosts = true;
                                        myVotedProviders
                                            .setOnGetTotalPostsCompleted = () {
                                          setState(() {});
                                        };
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
                                              color: ContentColors.darkOrange,
                                              fontSize:
                                                  ContentSizes.dp18(context),
                                            ),
                                      ),
                                    ),
                        ],
                      ),
                      SizedBox(
                        height: ContentSizes.height(context) * 0.015,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: ContentSizes.height(context) * 0.015,
                              ),
                              Row(
                                children: [
                                  Text(
                                    ContentTexts.sort,
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
                              _createdAtFilterWidget
                                  .createCreatedAtFilterWidget(
                                context,
                                myPostsProviders,
                                myVotedProviders,
                                isMyPosts,
                                () {
                                  setState(() {});
                                },
                              ),
                              SizedBox(
                                height: ContentSizes.height(context) * 0.03,
                              ),
                              Row(
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
                                    onTap: () {
                                      isMyPosts
                                          ? myPostsProviders
                                              .setSelectedSeeAllCategoryFilterList()
                                          : myVotedProviders
                                              .setSelectedSeeAllCategoryFilterList();
                                      showModalBottomSheet(
                                        backgroundColor: ContentColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return isMyPosts
                                              ? SeeAllBottomSheetWidget(
                                                  myPostsProviders:
                                                      myPostsProviders,
                                                  isMyPosts: true,
                                                )
                                              : SeeAllBottomSheetWidget(
                                                  myVotedProviders:
                                                      myVotedProviders,
                                                );
                                        },
                                      );
                                    },
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
                                            color: ContentColors.darkOrange,
                                            fontSize:
                                                ContentSizes.dp16(context),
                                          ),
                                    ),
                                  )
                                ],
                              ),
                              _categoryFilterWidget.createCategoryFilterWidget(
                                context,
                                myPostsProviders,
                                myVotedProviders,
                                isMyPosts,
                                () {
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isMyPosts
                    ? myPostsProviders.selectedSort ==
                                myPostsProviders.savedCreatedAt &&
                            unOrderedDeepEq(
                                myPostsProviders.selectedCategoryFilterList,
                                myPostsProviders.savedCategoryFilterList)
                        ? Container()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: ContentColors.white,
                              height: ContentSizes.height(context) * 0.085,
                              width: ContentSizes.width(context),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    ContentSizes.width(context) * 0.05,
                                    ContentSizes.width(context) * 0.02,
                                    ContentSizes.width(context) * 0.05,
                                    ContentSizes.width(context) * 0.02,
                                  ),
                                  child: myPostsProviders
                                          .isWaitingForGetTotalPosts
                                      ? Loading(
                                          color: ContentColors.orange,
                                          indicator:
                                              BallSpinFadeLoaderIndicator(),
                                          size: ContentSizes.height(context) *
                                              0.05,
                                        )
                                      : myPostsProviders.totalPosts == 0
                                          ? Text(
                                              ContentTexts.noResult,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              textDirection: TextDirection.ltr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  .copyWith(
                                                    color: ContentColors
                                                        .darkOrange,
                                                    fontSize: ContentSizes.dp16(
                                                        context),
                                                  ),
                                            )
                                          : _actionButtonWidget
                                              .createActionButtonWidget(
                                              context,
                                              ContentColors.orange,
                                              ContentColors.white,
                                              myPostsProviders.totalPosts == 1
                                                  ? 'Show ${myPostsProviders.totalPosts} result'
                                                  : 'Show all ${myPostsProviders.totalPosts} result',
                                              () {
                                                myPostsProviders
                                                    .saveFilterChanges();
                                                myPostsProviders
                                                    .setMyPostSnapshot();
                                                Navigator.pop(context);
                                              },
                                              isFilter: true,
                                            ),
                                ),
                              ),
                            ),
                          )
                    : myVotedProviders.selectedSort ==
                                myVotedProviders.savedCreatedAt &&
                            unOrderedDeepEq(
                                myVotedProviders.selectedCategoryFilterList,
                                myVotedProviders.savedCategoryFilterList)
                        ? Container()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: ContentColors.white,
                              height: ContentSizes.height(context) * 0.085,
                              width: ContentSizes.width(context),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    ContentSizes.width(context) * 0.05,
                                    ContentSizes.width(context) * 0.02,
                                    ContentSizes.width(context) * 0.05,
                                    ContentSizes.width(context) * 0.02,
                                  ),
                                  child: myVotedProviders
                                          .isWaitingForGetTotalPosts
                                      ? Loading(
                                          color: ContentColors.orange,
                                          indicator:
                                              BallSpinFadeLoaderIndicator(),
                                          size: ContentSizes.height(context) *
                                              0.05,
                                        )
                                      : myVotedProviders.totalPosts == 0
                                          ? Text(
                                              ContentTexts.noResult,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              textDirection: TextDirection.ltr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  .copyWith(
                                                    color: ContentColors
                                                        .darkOrange,
                                                    fontSize: ContentSizes.dp16(
                                                        context),
                                                  ),
                                            )
                                          : _actionButtonWidget
                                              .createActionButtonWidget(
                                              context,
                                              ContentColors.orange,
                                              ContentColors.white,
                                              myVotedProviders.totalPosts == 1
                                                  ? 'Show ${myVotedProviders.totalPosts} result'
                                                  : 'Show all ${myVotedProviders.totalPosts} result',
                                              () {
                                                myVotedProviders
                                                    .saveFilterChanges();
                                                myVotedProviders
                                                    .setMyVotedSnapshot();
                                                Navigator.pop(context);
                                              },
                                              isFilter: true,
                                            ),
                                ),
                              ),
                            ),
                          )
              ],
            ),
    );
  }
}
