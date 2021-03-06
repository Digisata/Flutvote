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
          margin: EdgeInsets.only(right: ContentSizes.width(context) * 0.01),
          child: GestureDetector(
            child: Chip(
              backgroundColor: !_isSelectedCategory &&
                      ContentTexts.categoryList[index] != 'All'
                  ? Colors.white
                  : ContentTexts.categoryList[index] == 'All' &&
                          _homeProviders.selectedCategoryList.length > 0
                      ? Colors.white
                      : ContentColors.orange,
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
                        ? ContentColors.grey
                        : ContentTexts.categoryList[index] == 'All' &&
                                _homeProviders.selectedCategoryList.length > 0
                            ? ContentColors.grey
                            : Colors.white,
                    fontSize: ContentSizes.dp16(context),
                  ),
            ),
            onTap: () async {
              if (ContentTexts.categoryList[index] != 'All') {
                if (!_isSelectedCategory) {
                  if (_homeProviders.selectedCategoryList.length < 10) {
                    _homeProviders.addSelectedCategoryList =
                        ContentTexts.categoryList[index];
                    await _homeProviders.setTotalPosts();
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
                  await _homeProviders.setTotalPosts();
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
