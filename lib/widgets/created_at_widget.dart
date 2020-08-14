import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';

class CreatedAtWidget extends StatelessWidget {
  final VoidCallback onItemSelected;
  final MyPostsProviders _myPostsProviders;
  final MyVotedProviders _myVotedProviders;
  final _isMyPosts;

  CreatedAtWidget(
    this.onItemSelected,
    this._myPostsProviders,
    this._myVotedProviders,
    this._isMyPosts,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ContentTexts.createdAtList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        bool _isSelectedCreatedAt = _isMyPosts
            ? ContentTexts.createdAtList[index] ==
                _myPostsProviders.selectedCreatedAt
            : ContentTexts.createdAtList[index] ==
                _myVotedProviders.selectedCreatedAt;
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
                color: !_isSelectedCreatedAt
                    ? Colors.transparent
                    : ContentColors.orange,
              ),
              child: Text(
                ContentTexts.createdAtList[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: !_isSelectedCreatedAt
                          ? ContentColors.grey
                          : Colors.white,
                      fontSize: ContentSizes.dp16(context),
                    ),
              ),
            ),
            onTap: () async {
              if (_isMyPosts) {
                _myPostsProviders.setSelectedCreatedAt =
                    ContentTexts.createdAtList[index];
                _myPostsProviders.setTotalPosts();
                _myPostsProviders.checkMyPostsIsDefaultFilter();
              } else {
                _myVotedProviders.setSelectedCreatedAt =
                    ContentTexts.createdAtList[index];
                _myVotedProviders.setTotalVoted();
                _myVotedProviders.checkMyVotedIsDefaultFilter();
              }
              onItemSelected();
            },
          ),
        );
      },
    );
  }
}
