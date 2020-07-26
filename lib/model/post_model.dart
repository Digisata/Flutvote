import 'package:meta/meta.dart';
import 'dart:convert';

class PostModel {
  PostModel({
    @required this.uid,
    @required this.username,
    @required this.email,
    @required this.displayName,
    @required this.imageUrl,
    @required this.title,
    @required this.description,
    @required this.options,
    @required this.totalVotes,
  });

  final String uid;
  final String username;
  final String email;
  final String displayName;
  final String imageUrl;
  final String title;
  final String description;
  final List<String> options;
  final int totalVotes;

  PostModel copyWith({
    String uid,
    String username,
    String email,
    String displayName,
    String imageUrl,
    String title,
    String description,
    List<String> options,
    int voteSum,
  }) =>
      PostModel(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        imageUrl: imageUrl ?? this.imageUrl,
        title: title ?? this.title,
        description: description ?? this.description,
        options: options ?? this.options,
        totalVotes: voteSum ?? this.totalVotes,
      );

  factory PostModel.fromJson(String str) => PostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        displayName: json["displayName"],
        imageUrl: json["imageUrl"],
        title: json["title"],
        description: json["description"],
        options: List<String>.from(json["options"].map((x) => x)),
        totalVotes: json["totalVotes"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "username": username,
        "email": email,
        "displayName": displayName,
        "imageUrl": imageUrl,
        "title": title,
        "description": description,
        "options": List<dynamic>.from(options.map((x) => x)),
        "totalVotes": totalVotes,
      };
}
