import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class HistoryRoute extends StatelessWidget {
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();
  final PostItemWidget _postItemWidget = PostItemWidget();

  @override
  Widget build(BuildContext context) {
    final MyPostsProviders _myPostsProviders =
        Provider.of<MyPostsProviders>(context);
    final MyVotedProviders _myVotedProviders =
        Provider.of<MyVotedProviders>(context);

    final Text _history = Text(
      ContentTexts.history,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Text _myPosts = Text(
      ContentTexts.myPosts,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp20(context),
          ),
    );

    final Text _myVoted = Text(
      ContentTexts.myVoted,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp20(context),
          ),
    );

    final Padding _myPostsFilterButton = Padding(
      padding: EdgeInsets.only(
        left: ContentSizes.width(context) * 0.05,
        right: ContentSizes.width(context) * 0.05,
      ),
      child: Row(
        children: [
          GestureDetector(
            child: Chip(
              backgroundColor: ContentColors.white,
              label: Row(
                children: [
                  _myPostsProviders.savedCreatedAt == 'Newest' &&
                          _myPostsProviders.savedCategoryFilterList.isNotEmpty
                      ? CircleAvatar(
                          backgroundColor: ContentColors.orange,
                          radius: ContentSizes.width(context) * 0.025,
                          child: Text(
                            '${_myPostsProviders.savedCategoryFilterList.length}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            style:
                                Theme.of(context).textTheme.headline2.copyWith(
                                      color: ContentColors.white,
                                      fontSize: ContentSizes.dp13(context),
                                    ),
                          ),
                        )
                      : _myPostsProviders.savedCreatedAt != 'Newest' &&
                              _myPostsProviders
                                  .savedCategoryFilterList.isNotEmpty
                          ? CircleAvatar(
                              backgroundColor: ContentColors.orange,
                              radius: ContentSizes.width(context) * 0.025,
                              child: Text(
                                '${_myPostsProviders.savedCategoryFilterList.length + 1}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.ltr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                      color: ContentColors.white,
                                      fontSize: ContentSizes.dp13(context),
                                    ),
                              ),
                            )
                          : _myPostsProviders.savedCreatedAt != 'Newest'
                              ? CircleAvatar(
                                  backgroundColor: ContentColors.orange,
                                  radius: ContentSizes.width(context) * 0.025,
                                  child: Text(
                                    '1',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.ltr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(
                                          color: ContentColors.white,
                                          fontSize: ContentSizes.dp13(context),
                                        ),
                                  ),
                                )
                              : Image.asset(
                                  'assets/icons/filter_icon.png',
                                  height: ContentSizes.height(context) * 0.025,
                                  width: ContentSizes.height(context) * 0.025,
                                ),
                  SizedBox(
                    width: ContentSizes.width(context) * 0.01,
                  ),
                  Text(
                    ContentTexts.filter,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ContentColors.darkGrey,
                          fontSize: ContentSizes.dp18(context),
                        ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: ContentColors.softGrey,
                ),
              ),
            ),
            onTap: () {
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
                  return BottomSheetWidget(
                    myPostsProviders: _myPostsProviders,
                    isMyPosts: true,
                  );
                },
              ).then(
                (value) => _myPostsProviders.setSavedFilter(),
              );
            },
          ),
        ],
      ),
    );

    final Padding _myVotedFilterButton = Padding(
      padding: EdgeInsets.only(
        left: ContentSizes.width(context) * 0.05,
        right: ContentSizes.width(context) * 0.05,
      ),
      child: Row(
        children: [
          GestureDetector(
            child: Chip(
              backgroundColor: ContentColors.white,
              label: Row(
                children: [
                  _myVotedProviders.savedCreatedAt == 'Newest' &&
                          _myVotedProviders.savedCategoryFilterList.isNotEmpty
                      ? CircleAvatar(
                          backgroundColor: ContentColors.orange,
                          radius: ContentSizes.width(context) * 0.025,
                          child: Text(
                            '${_myVotedProviders.savedCategoryFilterList.length}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            style:
                                Theme.of(context).textTheme.headline2.copyWith(
                                      color: ContentColors.white,
                                      fontSize: ContentSizes.dp13(context),
                                    ),
                          ),
                        )
                      : _myVotedProviders.savedCreatedAt != 'Newest' &&
                              _myVotedProviders
                                  .savedCategoryFilterList.isNotEmpty
                          ? CircleAvatar(
                              backgroundColor: ContentColors.orange,
                              radius: ContentSizes.width(context) * 0.025,
                              child: Text(
                                '${_myVotedProviders.savedCategoryFilterList.length + 1}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.ltr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                      color: ContentColors.white,
                                      fontSize: ContentSizes.dp13(context),
                                    ),
                              ),
                            )
                          : _myVotedProviders.savedCreatedAt != 'Newest'
                              ? CircleAvatar(
                                  backgroundColor: ContentColors.orange,
                                  radius: ContentSizes.width(context) * 0.025,
                                  child: Text(
                                    '1',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.ltr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(
                                          color: ContentColors.white,
                                          fontSize: ContentSizes.dp13(context),
                                        ),
                                  ),
                                )
                              : Image.asset(
                                  'assets/icons/filter_icon.png',
                                  height: ContentSizes.height(context) * 0.025,
                                  width: ContentSizes.height(context) * 0.025,
                                ),
                  SizedBox(
                    width: ContentSizes.width(context) * 0.01,
                  ),
                  Text(
                    ContentTexts.filter,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ContentColors.darkGrey,
                          fontSize: ContentSizes.dp18(context),
                        ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: ContentColors.softGrey,
                ),
              ),
            ),
            onTap: () {
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
                  return BottomSheetWidget(
                    myVotedProviders: _myVotedProviders,
                  );
                },
              ).then(
                (value) => _myVotedProviders.setSavedFilter(),
              );
            },
          ),
        ],
      ),
    );

    final StreamBuilder _myPostList = StreamBuilder<QuerySnapshot>(
      stream: _myPostsProviders.myPostSnapshot,
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          return Expanded(
            child: Loading(
              color: ContentColors.orange,
              indicator: BallPulseIndicator(),
              size: ContentSizes.height(context) * 0.1,
            ),
          );
        } else if (snapshots.hasError) {
          return _alertDialogWidget.createAlertDialogWidget(
            context,
            ContentTexts.oops,
            ContentTexts.errorRetrieveData,
            ContentTexts.ok,
          );
        } else if (snapshots.data.documents.isEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                ContentTexts.haventCreatedPostyet,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
                style: Theme.of(context).textTheme.headline1.copyWith(
                      color: ContentColors.grey,
                      fontSize: ContentSizes.dp18(context),
                    ),
              ),
            ),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                left: ContentSizes.width(context) * 0.05,
                right: ContentSizes.width(context) * 0.05,
              ),
              itemCount: snapshots.data.documents.length,
              itemBuilder: (context, index) {
                return _postItemWidget.createPostItemWidget(
                  context,
                  snapshots.data.documents.elementAt(index),
                  index,
                  isMyPost: true,
                );
              },
            ),
          );
        }
      },
    );

    final StreamBuilder _myVotedList = StreamBuilder<QuerySnapshot>(
      stream: _myVotedProviders.myVotedSnapshot,
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          return Expanded(
            child: Loading(
              color: ContentColors.orange,
              indicator: BallPulseIndicator(),
              size: ContentSizes.height(context) * 0.1,
            ),
          );
        } else if (snapshots.hasError) {
          return _alertDialogWidget.createAlertDialogWidget(
            context,
            ContentTexts.oops,
            ContentTexts.errorRetrieveData,
            ContentTexts.ok,
          );
        } else if (snapshots.data.documents.isEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                ContentTexts.haventVotedyet,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
                style: Theme.of(context).textTheme.headline1.copyWith(
                      color: ContentColors.grey,
                      fontSize: ContentSizes.dp18(context),
                    ),
              ),
            ),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                left: ContentSizes.width(context) * 0.05,
                right: ContentSizes.width(context) * 0.05,
              ),
              itemCount: snapshots.data.documents.length,
              itemBuilder: (context, index) {
                return _postItemWidget.createPostItemWidget(
                  context,
                  snapshots.data.documents.elementAt(index),
                  index,
                  isMyVoted: true,
                );
              },
            ),
          );
        }
      },
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(
                child: _myPosts,
              ),
              Tab(
                child: _myVoted,
              ),
            ],
            labelColor: ContentColors.orange,
            unselectedLabelColor: ContentColors.backgroundDarkGrey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: ContentColors.orange,
            indicatorWeight: 3,
          ),
          elevation: 0.0,
          title: _history,
        ),
        body: Center(
          child: TabBarView(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    _myPostsFilterButton,
                    _myPostList,
                  ],
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    _myVotedFilterButton,
                    _myVotedList,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
