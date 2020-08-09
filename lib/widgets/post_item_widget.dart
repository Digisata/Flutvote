import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/model/models.dart';

class PostItemWidget {
  GestureDetector createPostItemWidget(
    BuildContext _context,
    DocumentSnapshot _documentSnapshot,
    int index, {
    bool isMyPost = false,
    isMyVoted = false,
  }) {
    final PostModel _postModel = PostModel.fromMap(_documentSnapshot.data);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          _context,
          ContentTexts.detailPostRoute,
          arguments: {
            'documentSnapshot': _documentSnapshot,
            'index': index,
            'isMyPost': isMyPost,
            'isMyVoted': isMyVoted,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
          ContentSizes.width(_context) * 0.03,
          ContentSizes.height(_context) * 0.01,
          ContentSizes.width(_context) * 0.03,
          ContentSizes.height(_context) * 0.01,
        ),
        margin: EdgeInsets.only(bottom: ContentSizes.height(_context) * 0.02),
        height: ContentSizes.height(_context) * 0.15,
        width: ContentSizes.width(_context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: ContentColors.backgroundDarkGrey,
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: '${ContentTexts.postImageTag}$index',
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: _postModel.imageUrl,
                    progressIndicatorBuilder: (context, url, download) =>
                        Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: ContentSizes.height(_context),
                        width: ContentSizes.width(_context) * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          shape: BoxShape.rectangle,
                          color: Colors.transparent,
                        ),
                        child: CircularProgressIndicator(
                          value: download.progress,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.center,
                      height: ContentSizes.height(_context),
                      width: ContentSizes.width(_context) * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        shape: BoxShape.rectangle,
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ContentSizes.width(_context) * 0.02,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _postModel.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style:
                              Theme.of(_context).textTheme.headline2.copyWith(
                                    color: ContentColors.darkGrey,
                                    fontSize: ContentSizes.dp20(_context),
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          _postModel.displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style:
                              Theme.of(_context).textTheme.headline2.copyWith(
                                    color: ContentColors.darkGrey,
                                    fontSize: ContentSizes.dp14(_context),
                                  ),
                        ),
                      ],
                    ),
                    Text(
                      _postModel.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: Theme.of(_context).textTheme.headline2.copyWith(
                            color: ContentColors.darkGrey,
                            fontSize: ContentSizes.dp12(_context),
                          ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _postModel.totalVotes.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: Theme.of(_context).textTheme.headline2.copyWith(
                        color: ContentColors.darkGrey,
                        fontSize: ContentSizes.dp20(_context),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  ContentTexts.voted,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: Theme.of(_context).textTheme.headline2.copyWith(
                        color: ContentColors.darkGrey,
                        fontSize: ContentSizes.dp12(_context),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
