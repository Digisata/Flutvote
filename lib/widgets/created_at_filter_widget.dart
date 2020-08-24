import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';

class CreatedAtFilterWidget {
  Align createCreatedAtFilterWidget(
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
        children: ContentTexts.createdAtList.map(
          (element) {
            bool _isSelectedCreatedAt = _isMyPosts
                ? _myPostsProviders.selectedSort == element
                : _myVotedProviders.selectedSort == element;
            return GestureDetector(
              child: Chip(
                backgroundColor: !_isSelectedCreatedAt
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
                      color: !_isSelectedCreatedAt
                          ? ContentColors.darkGrey
                          : ContentColors.orange,
                      fontSize: ContentSizes.dp16(_context),
                    ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: !_isSelectedCreatedAt
                        ? ContentColors.softGrey
                        : ContentColors.orange,
                  ),
                ),
              ),
              onTap: () {
                if (_isMyPosts) {
                  if (!_isSelectedCreatedAt) {
                    _myPostsProviders.setSelectedCreatedAt = element;
                    _myPostsProviders.setTotalPosts();
                    _myPostsProviders.isWaitingForGetTotalPosts = true;
                    _myPostsProviders.setOnGetTotalPostsCompleted = () {
                      _onItemSelected();
                    };
                    _myPostsProviders.checkMyPostsIsDefaultFilter();
                  }
                } else {
                  if (!_isSelectedCreatedAt) {
                    _myVotedProviders.setSelectedCreatedAt = element;
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
