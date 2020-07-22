import 'package:meta/meta.dart';
import 'dart:convert';

class PostModel {
  PostModel({
    @required this.uid,
    @required this.username,
    @required this.email,
    @required this.displayName,
    @required this.postTitle,
    @required this.postDescription,
    @required this.voteSum,
  });

  final String uid;
  final String username;
  final String email;
  final String displayName;
  final String postTitle;
  final String postDescription;
  final int voteSum;

  PostModel copyWith({
    String uid,
    String username,
    String email,
    String displayName,
    String postTitle,
    String postDescription,
    int voteSum,
  }) =>
      PostModel(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        postTitle: postTitle ?? this.postTitle,
        postDescription: postDescription ?? this.postDescription,
        voteSum: voteSum ?? this.voteSum,
      );

  factory PostModel.fromJson(String str) => PostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        displayName: json["displayName"],
        postTitle: json["postTitle"],
        postDescription: json["postDescription"],
        voteSum: json["voteSum"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "username": username,
        "email": email,
        "displayName": displayName,
        "postTitle": postTitle,
        "postDescription": postDescription,
        "voteSum": voteSum,
      };
}
