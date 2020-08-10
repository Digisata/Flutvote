import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class PostModel {
  PostModel({
    @required this.categories,
    @required this.description,
    @required this.deviceId,
    @required this.displayName,
    @required this.email,
    @required this.imageUrl,
    @required this.options,
    @required this.photoUrl,
    @required this.timeCreated,
    @required this.title,
    @required this.totalVotes,
    @required this.uid,
    @required this.username,
  });

  final List<String> categories;
  final String description;
  final String deviceId;
  final String displayName;
  final String email;
  final String imageUrl;
  final List<Option> options;
  final String photoUrl;
  final Timestamp timeCreated;
  final String title;
  final int totalVotes;
  final String uid;
  final String username;

  PostModel copyWith({
    List<String> categories,
    String description,
    String deviceId,
    String displayName,
    String email,
    String imageUrl,
    List<Option> options,
    String photoUrl,
    Timestamp timeCreated,
    String title,
    int totalVotes,
    String uid,
    String username,
  }) =>
      PostModel(
        categories: categories ?? this.categories,
        description: description ?? this.description,
        deviceId: deviceId ?? this.deviceId,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
        options: options ?? this.options,
        photoUrl: photoUrl ?? this.photoUrl,
        timeCreated: timeCreated ?? this.timeCreated,
        title: title ?? this.title,
        totalVotes: totalVotes ?? this.totalVotes,
        uid: uid ?? this.uid,
        username: username ?? this.username,
      );

  factory PostModel.fromJson(String str) => PostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        categories: List<String>.from(json["categories"].map((x) => x)),
        description: json["description"],
        deviceId: json["deviceId"],
        displayName: json["displayName"],
        email: json["email"],
        imageUrl: json["imageUrl"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromMap(x))),
        photoUrl: json["photoUrl"],
        timeCreated: json["timeCreated"],
        title: json["title"],
        totalVotes: json["totalVotes"],
        uid: json["uid"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "description": description,
        "deviceId": deviceId,
        "displayName": displayName,
        "email": email,
        "imageUrl": imageUrl,
        "options": List<dynamic>.from(options.map((x) => x.toMap())),
        "photoUrl": photoUrl,
        "timeCreated": timeCreated,
        "title": title,
        "totalVotes": totalVotes,
        "uid": uid,
        "username": username,
      };
}

class Option {
  Option({
    @required this.option,
    @required this.votes,
  });

  final String option;
  final int votes;

  Option copyWith({
    String option,
    int votes,
  }) =>
      Option(
        option: option ?? this.option,
        votes: votes ?? this.votes,
      );

  factory Option.fromJson(String str) => Option.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Option.fromMap(Map<String, dynamic> json) => Option(
        option: json["option"],
        votes: json["votes"],
      );

  Map<String, dynamic> toMap() => {
        "option": option,
        "votes": votes,
      };
}
