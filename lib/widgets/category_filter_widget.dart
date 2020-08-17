import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/widgets/widgets.dart';

class CategoryFilterWidget extends StatelessWidget {
  final VoidCallback onItemSelected;
  final MyPostsProviders _myPostsProviders;
  final MyVotedProviders _myVotedProviders;
  final _isMyPosts;
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();

  CategoryFilterWidget(
    this.onItemSelected,
    this._myPostsProviders,
    this._myVotedProviders,
    this._isMyPosts,
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
          textDirection: TextDirection.ltr,
          spacing: ContentSizes.width(context) * 0.01,
          children: ContentTexts.categoryFilterList.map(
            (element) {
              bool _isSelectedCategoryFilter = _isMyPosts
                  ? _myPostsProviders.selectedCategoryFilterList
                      .contains(element)
                  : _myVotedProviders.selectedCategoryFilterList
                      .contains(element);
              return GestureDetector(
                child: Chip(
                  backgroundColor: !_isSelectedCategoryFilter
                      ? Colors.transparent
                      : ContentColors.orange,
                  label: Text(
                    element,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                  ),
                  labelStyle: Theme.of(context).textTheme.headline2.copyWith(
                        color: !_isSelectedCategoryFilter
                            ? ContentColors.grey
                            : Colors.white,
                        fontSize: ContentSizes.dp16(context),
                      ),
                ),
                onTap: () {
                  if (_isMyPosts) {
                    if (!_isSelectedCategoryFilter) {
                      if (_myPostsProviders.selectedCategoryFilterList.length <
                          10) {
                        _myPostsProviders.addSelectedCategoryFilterList =
                            element;
                        _myPostsProviders.setTotalPosts();
                        _myPostsProviders.checkMyPostsIsDefaultFilter();
                      } else {
                        _alertDialogWidget.createAlertDialogWidget(
                          context,
                          ContentTexts.oops,
                          ContentTexts.errorOnlyCanSelect10,
                          ContentTexts.ok,
                        );
                      }
                    } else {
                      _myPostsProviders.removeSelectedCategoryFilterList =
                          element;
                      _myPostsProviders.setTotalPosts();
                      _myPostsProviders.checkMyPostsIsDefaultFilter();
                    }
                  } else {
                    if (!_isSelectedCategoryFilter) {
                      if (_myVotedProviders.selectedCategoryFilterList.length <
                          10) {
                        _myVotedProviders.addSelectedCategoryFilterList =
                            element;
                        _myVotedProviders.setTotalVoted();
                        _myVotedProviders.checkMyVotedIsDefaultFilter();
                      } else {
                        _alertDialogWidget.createAlertDialogWidget(
                          context,
                          ContentTexts.oops,
                          ContentTexts.errorOnlyCanSelect10,
                          ContentTexts.ok,
                        );
                      }
                    } else {
                      _myVotedProviders.removeSelectedCategoryFilterList =
                          element;
                      _myVotedProviders.setTotalVoted();
                      _myVotedProviders.checkMyVotedIsDefaultFilter();
                    }
                  }
                  onItemSelected();
                },
              );
            },
          ).toList()),
    );
  }
}
