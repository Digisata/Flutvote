import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/widgets/widgets.dart';

class CategoryWidget {
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();

  ListView createCategoryWidget(
    BuildContext _context,
    HomeProviders _homeProviders,
  ) {
    return ListView.builder(
      itemCount: ContentTexts.categoryList.length,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: ContentSizes.width(_context) * 0.05),
      itemBuilder: (context, index) {
        bool _isSelectedCategory = _homeProviders.selectedCategoryList
            .contains(ContentTexts.categoryList[index]);
        return Container(
          margin: EdgeInsets.only(right: ContentSizes.width(context) * 0.015),
          child: GestureDetector(
            child: Chip(
              backgroundColor: !_isSelectedCategory &&
                      ContentTexts.categoryList[index] != 'All'
                  ? ContentColors.white
                  : ContentTexts.categoryList[index] == 'All' &&
                          _homeProviders.selectedCategoryList.length > 0
                      ? ContentColors.white
                      : ContentColors.softOrangeWithOpacity,
              label: Text(
                ContentTexts.categoryList[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
              ),
              labelStyle: Theme.of(context).textTheme.headline2.copyWith(
                    color: !_isSelectedCategory &&
                            ContentTexts.categoryList[index] != 'All'
                        ? ContentColors.darkGrey
                        : ContentTexts.categoryList[index] == 'All' &&
                                _homeProviders.selectedCategoryList.length > 0
                            ? ContentColors.darkGrey
                            : ContentColors.orange,
                    fontSize: ContentSizes.dp16(context),
                  ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: !_isSelectedCategory &&
                          ContentTexts.categoryList[index] != 'All'
                      ? ContentColors.softGrey
                      : ContentTexts.categoryList[index] == 'All' &&
                              _homeProviders.selectedCategoryList.length > 0
                          ? ContentColors.softGrey
                          : ContentColors.orange,
                ),
              ),
            ),
            onTap: () {
              if (ContentTexts.categoryList[index] != 'All') {
                if (!_isSelectedCategory) {
                  if (_homeProviders.selectedCategoryList.length < 10) {
                    _homeProviders.addSelectedCategoryList =
                        ContentTexts.categoryList[index];
                    _homeProviders.setTotalPosts();
                    _homeProviders.isWaitingForGetTotalPosts = true;
                    _homeProviders.checkIsDefaultFilter();
                    _homeProviders.setPostSnapshots();
                  } else {
                    _alertDialogWidget.createAlertDialogWidget(
                      context,
                      ContentTexts.oops,
                      ContentTexts.errorOnlyCanSelect10,
                      ContentTexts.ok,
                    );
                  }
                } else {
                  _homeProviders.removeSelectedCategoryList =
                      ContentTexts.categoryList[index];
                  _homeProviders.setTotalPosts();
                  _homeProviders.isWaitingForGetTotalPosts = true;
                  _homeProviders.checkIsDefaultFilter();
                  _homeProviders.setPostSnapshots();
                }
              } else {
                _homeProviders.resetPostsFilter();
                _homeProviders.setPostSnapshots();
              }
            },
          ),
        );
      },
    );
  }
}
