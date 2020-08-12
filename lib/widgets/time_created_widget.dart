import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';

class TimeCreatedWidget extends StatelessWidget {
  final VoidCallback onItemSelected;
  final MyPostsProviders _myPostsProviders;

  TimeCreatedWidget(this.onItemSelected, this._myPostsProviders);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ContentTexts.timeCreatedList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        bool _isSelectedTimeCreated = ContentTexts.timeCreatedList[index] ==
            _myPostsProviders.selectedTimeCreated;
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
                color: !_isSelectedTimeCreated
                    ? Colors.transparent
                    : ContentColors.orange,
              ),
              child: Text(
                ContentTexts.timeCreatedList[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: !_isSelectedTimeCreated
                          ? ContentColors.grey
                          : Colors.white,
                      fontSize: ContentSizes.dp16(context),
                    ),
              ),
            ),
            onTap: () async {
              _myPostsProviders.setSelectedTimeCreated =
                  ContentTexts.timeCreatedList[index];
              _myPostsProviders.setTotalPosts();
              _myPostsProviders.checkMyPostsIsDefaultFilter();
              onItemSelected();
            },
          ),
        );
      },
    );
  }
}
