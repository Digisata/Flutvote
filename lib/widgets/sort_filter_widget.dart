import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';

class SortFilterWidget {
  Align createSortFilterWidget(
    BuildContext _context,
    MyPostsProviders _myPostsProviders,
    MyVotedProviders _myVotedProviders,
    bool _isMyPosts,
    VoidCallback _onItemSelected,
  ) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        textDirection: TextDirection.ltr,
        spacing: ContentSizes.width(_context) * 0.01,
        children: ContentTexts.sortList.map(
          (element) {
            bool _isSelectedSort = _isMyPosts
                ? _myPostsProviders.selectedSort == element
                : _myVotedProviders.selectedSort == element;
            return GestureDetector(
              child: Chip(
                backgroundColor: !_isSelectedSort
                    ? ContentColors.white
                    : ContentColors.softOrangeWithOpacity,
                label: Text(
                  element,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
                labelStyle: Theme.of(_context).textTheme.headline2.copyWith(
                      color: !_isSelectedSort
                          ? ContentColors.darkGrey
                          : ContentColors.orange,
                      fontSize: ContentSizes.dp16(_context),
                    ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: !_isSelectedSort
                        ? ContentColors.softGrey
                        : ContentColors.orange,
                  ),
                ),
              ),
              onTap: () {
                if (_isMyPosts) {
                  if (!_isSelectedSort) {
                    _myPostsProviders.setSelectedSort = element;
                    _myPostsProviders.setTotalPosts();
                    _myPostsProviders.isWaitingForGetTotalPosts = true;
                    _myPostsProviders.setOnGetTotalPostsCompleted = () {
                      _onItemSelected();
                    };
                    _myPostsProviders.checkMyPostsIsDefaultFilter();
                  }
                } else {
                  if (!_isSelectedSort) {
                    _myVotedProviders.setSelectedSort = element;
                    _myVotedProviders.setTotalVoted();
                    _myVotedProviders.isWaitingForGetTotalPosts = true;
                    _myVotedProviders.setOnGetTotalPostsCompleted = () {
                      _onItemSelected();
                    };
                    _myVotedProviders.checkMyVotedIsDefaultFilter();
                  }
                }
                _onItemSelected();
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
