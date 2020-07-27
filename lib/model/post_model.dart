import 'package:cloud_firestore/cloud_firestore.dart';
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
    @required this.totalVotes,
    @required this.detailVotes,
  });

  final String uid;
  final String username;
  final String email;
  final String displayName;
  final String imageUrl;
  final String title;
  final String description;
  final int totalVotes;
  final DetailVotes detailVotes;

  PostModel copyWith({
    String uid,
    String username,
    String email,
    String displayName,
    String imageUrl,
    String title,
    String description,
    int totalVotes,
    DetailVotes detailVotes,
    DocumentReference reference,
  }) =>
      PostModel(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        imageUrl: imageUrl ?? this.imageUrl,
        title: title ?? this.title,
        description: description ?? this.description,
        totalVotes: totalVotes ?? this.totalVotes,
        detailVotes: detailVotes ?? this.detailVotes,
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
        totalVotes: json["totalVotes"],
        detailVotes: DetailVotes.fromMap(json["detailVotes"]),
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "username": username,
        "email": email,
        "displayName": displayName,
        "imageUrl": imageUrl,
        "title": title,
        "description": description,
        "totalVotes": totalVotes,
        "detailVotes": detailVotes.toMap(),
      };
}

class DetailVotes {
  DetailVotes({
    @required this.jogja,
    @required this.bali,
  });

  final int jogja;
  final int bali;

  DetailVotes copyWith({
    int jogja,
    int bali,
  }) =>
      DetailVotes(
        jogja: jogja ?? this.jogja,
        bali: bali ?? this.bali,
      );

  factory DetailVotes.fromJson(String str) =>
      DetailVotes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailVotes.fromMap(Map<String, dynamic> json) => DetailVotes(
        jogja: json["Jogja"],
        bali: json["Bali"],
      );

  Map<String, dynamic> toMap() => {
        "Jogja": jogja,
        "Bali": bali,
      };
}
