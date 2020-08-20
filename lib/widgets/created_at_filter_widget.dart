import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';

class CreatedAtFilterWidget extends StatelessWidget {
  final VoidCallback onItemSelected;
  final MyPostsProviders _myPostsProviders;
  final MyVotedProviders _myVotedProviders;
  final _isMyPosts;

  CreatedAtFilterWidget(
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
        children: ContentTexts.createdAtList.map(
          (element) {
            bool _isSelectedCreatedAt = _isMyPosts
                ? _myPostsProviders.selectedCreatedAt == element
                : _myVotedProviders.selectedCreatedAt == element;
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
                labelStyle: Theme.of(context).textTheme.headline2.copyWith(
                      color: !_isSelectedCreatedAt
                          ? ContentColors.darkGrey
                          : ContentColors.orange,
                      fontSize: ContentSizes.dp16(context),
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
                      onItemSelected();
                    };
                    _myPostsProviders.checkMyPostsIsDefaultFilter();
                  }
                } else {
                  if (!_isSelectedCreatedAt) {
                    _myVotedProviders.setSelectedCreatedAt = element;
                    _myVotedProviders.setTotalVoted();
                    _myVotedProviders.isWaitingForGetTotalPosts = true;
                    _myVotedProviders.setOnGetTotalPostsCompleted = () {
                      onItemSelected();
                    };
                    _myVotedProviders.checkMyVotedIsDefaultFilter();
                  }
                }
                onItemSelected();
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
