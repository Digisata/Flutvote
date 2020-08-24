import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/widgets/widgets.dart';

class SeeAllBottomSheetWidget extends StatefulWidget {
  final MyPostsProviders myPostsProviders;
  final MyVotedProviders myVotedProviders;
  final bool isMyPosts;

  SeeAllBottomSheetWidget({
    this.myPostsProviders,
    this.myVotedProviders,
    this.isMyPosts = false,
  });

  @override
  _SeeAllBottomSheetWidgetState createState() => _SeeAllBottomSheetWidgetState(
        myPostsProviders: this.myPostsProviders,
        myVotedProviders: this.myVotedProviders,
        isMyPosts: this.isMyPosts,
      );
}

class _SeeAllBottomSheetWidgetState extends State<SeeAllBottomSheetWidget> {
  final MyPostsProviders myPostsProviders;
  final MyVotedProviders myVotedProviders;
  final bool isMyPosts;
  final SeeAllCategoryWidget _seeAllCategoryWidget = SeeAllCategoryWidget();

  _SeeAllBottomSheetWidgetState({
    this.myPostsProviders,
    this.myVotedProviders,
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
      height: ContentSizes.height(context) / 2,
      width: ContentSizes.width(context),
      child: Stack(
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
                      ContentTexts.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: ContentSizes.dp20(context),
                          ),
                    ),
                    isMyPosts
                        ? myPostsProviders.isDefaultFilter ||
                                myPostsProviders
                                    .selectedSeeAllCategoryFilterList.isEmpty
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  myPostsProviders.resetSeeAllCategoryFilter();
                                  setState(() {});
                                },
                                child: Text(
                                  '${ContentTexts.reset} (${myPostsProviders.selectedSeeAllCategoryFilterList.length})',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  textDirection: TextDirection.ltr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(
                                        color: ContentColors.darkOrange,
                                        fontSize: ContentSizes.dp18(context),
                                      ),
                                ),
                              )
                        : myVotedProviders.isDefaultFilter ||
                                myVotedProviders
                                    .selectedSeeAllCategoryFilterList.isEmpty
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  myVotedProviders.resetSeeAllCategoryFilter();
                                  setState(() {});
                                },
                                child: Text(
                                  '${ContentTexts.reset} (${myVotedProviders.selectedSeeAllCategoryFilterList.length})',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  textDirection: TextDirection.ltr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(
                                        color: ContentColors.darkOrange,
                                        fontSize: ContentSizes.dp18(context),
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
                        _seeAllCategoryWidget.createSeeAllCategoryWidget(
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
        ],
      ),
    );
  }
}
