import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/model/models.dart';

class PostItemWidget {
  Container createPostItemWidget(
      BuildContext _context, DocumentSnapshot _document) {
    final PostModel _post = PostModel.fromMap(_document.data);

    return Container(
      padding: EdgeInsets.fromLTRB(
        ContentSizes.width(_context) * 0.02,
        ContentSizes.height(_context) * 0.01,
        ContentSizes.width(_context) * 0.02,
        ContentSizes.height(_context) * 0.01,
      ),
      margin: EdgeInsets.only(bottom: ContentSizes.height(_context) * 0.01),
      width: ContentSizes.width(_context),
      height: ContentSizes.height(_context) * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: ContentColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            _post.postTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: Theme.of(_context).textTheme.headline2.copyWith(
                  fontSize: ContentSizes.dp18(_context),
                ),
          ),
          Text(
            _post.voteSum.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: Theme.of(_context).textTheme.headline2.copyWith(
                  fontSize: ContentSizes.dp18(_context),
                ),
          ),
        ],
      ),
    );
  }
}
