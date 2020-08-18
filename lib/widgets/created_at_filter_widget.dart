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
                      color: !_isSelectedCreatedAt
                          ? ContentColors.grey
                          : Colors.white,
                      fontSize: ContentSizes.dp16(context),
                    ),
              ),
              onTap: () async {
                if (_isMyPosts) {
                  if (!_isSelectedCreatedAt) {
                    _myPostsProviders.setSelectedCreatedAt = element;
                    await _myPostsProviders.setTotalPosts();
                    _myPostsProviders.checkMyPostsIsDefaultFilter();
                  }
                } else {
                  if (!_isSelectedCreatedAt) {
                    _myVotedProviders.setSelectedCreatedAt = element;
                    await _myVotedProviders.setTotalVoted();
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
