import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/widgets/widgets.dart';

class SeeAllCategoryWidget {
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();

  Column createSeeAllCategoryWidget(
    BuildContext _context,
    MyPostsProviders _myPostsProviders,
    MyVotedProviders _myVotedProviders,
    bool _isMyPosts,
    VoidCallback _onItemSelected,
  ) {
    return Column(
      children: ContentTexts.categoryList.map(
        (element) {
          bool _isSelectedCategoryFilter = _isMyPosts
              ? _myPostsProviders.selectedSeeAllCategoryFilterList
                  .contains(element)
              : _myVotedProviders.selectedSeeAllCategoryFilterList
                  .contains(element);
          return CheckboxListTile(
            activeColor: ContentColors.orange,
            checkColor: ContentColors.white,
            title: Text(
              element,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.ltr,
              style: Theme.of(_context).textTheme.headline2.copyWith(
                    color: ContentColors.darkGrey,
                    fontSize: ContentSizes.dp16(_context),
                  ),
            ),
            value: _isSelectedCategoryFilter,
            onChanged: (value) {
              if (_isMyPosts) {
                if (!_isSelectedCategoryFilter) {
                  if (_myPostsProviders
                          .selectedSeeAllCategoryFilterList.length <
                      10) {
                    _myPostsProviders.addSelectedSeeAllCategoryFilterList =
                        element;
                    _myPostsProviders.checkMyPostsIsDefaultFilter();
                  } else {
                    _alertDialogWidget.createAlertDialogWidget(
                      _context,
                      ContentTexts.oops,
                      ContentTexts.errorOnlyCanSelect10,
                      ContentTexts.ok,
                    );
                  }
                } else {
                  _myPostsProviders.removeSelectedSeeAllCategoryFilterList =
                      element;
                  _myPostsProviders.checkMyPostsIsDefaultFilter();
                }
              } else {
                if (!_isSelectedCategoryFilter) {
                  if (_myVotedProviders
                          .selectedSeeAllCategoryFilterList.length <
                      10) {
                    _myVotedProviders.addSelectedSeeAllCategoryFilterList =
                        element;
                    _myVotedProviders.checkMyVotedIsDefaultFilter();
                  } else {
                    _alertDialogWidget.createAlertDialogWidget(
                      _context,
                      ContentTexts.oops,
                      ContentTexts.errorOnlyCanSelect10,
                      ContentTexts.ok,
                    );
                  }
                } else {
                  _myVotedProviders.removeSelectedSeeAllCategoryFilterList =
                      element;
                  _myVotedProviders.checkMyVotedIsDefaultFilter();
                }
              }
              _onItemSelected();
            },
          );
        },
      ).toList(),
    );
  }
}
