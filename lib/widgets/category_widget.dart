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
        bool _isSelectedCategory =
            _homeProviders.selectedCategoryIndexList.contains(index);
        return Padding(
          padding: EdgeInsets.all(ContentSizes.height(context) * 0.003),
          child: GestureDetector(
            child: Container(
              height: ContentSizes.height(context) * 0.3,
              width: ContentSizes.width(context) * 0.2,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                ContentSizes.width(context) * 0.01,
                ContentSizes.height(context) * 0.005,
                ContentSizes.width(context) * 0.01,
                ContentSizes.height(context) * 0.005,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                shape: BoxShape.rectangle,
                color: !_isSelectedCategory &&
                        ContentTexts.categoryList[index] != 'All'
                    ? Colors.white
                    : ContentTexts.categoryList[index] == 'All' &&
                            _homeProviders.selectedCategoryList.length > 0
                        ? Colors.white
                        : ContentColors.orange,
              ),
              child: Text(
                ContentTexts.categoryList[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: Theme.of(context).textTheme.headline2.copyWith(
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
            ),
            onTap: () {
              if (ContentTexts.categoryList[index] != 'All') {
                if (!_isSelectedCategory) {
                  if (_homeProviders.selectedCategoryList.length < 10) {
                    _homeProviders.addSelectedCategoryList =
                        ContentTexts.categoryList[index];
                    _homeProviders.addSelectedCategoryIndexList = index;
                  } else {
                    _alertDialogWidget.createAlertDialogWidget(
                      context,
                      ContentTexts.oops,
                      ContentTexts.errorOnlyCanSelect10,
                      ContentTexts.ok,
                    );
                  }
                } else {
                  _homeProviders.deleteSelectedCategoryList =
                      ContentTexts.categoryList[index];
                  _homeProviders.deleteSelectedCategoryIndexList = index;
                }
              } else {
                _homeProviders.resetCategoryFilter();
              }
            },
          ),
        );
      },
    );
  }
}
