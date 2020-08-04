import 'package:meta/meta.dart';
import 'dart:convert';

class PostModel {
  PostModel({
    @required this.category,
    @required this.description,
    @required this.options,
    @required this.deviceId,
    @required this.displayName,
    @required this.email,
    @required this.imageUrl,
    @required this.photoUrl,
    @required this.title,
    @required this.totalVotes,
    @required this.uid,
    @required this.username,
  });

  final String category;
  final String description;
  final List<Option> options;
  final String deviceId;
  final String displayName;
  final String email;
  final String imageUrl;
  final String photoUrl;
  final String title;
  final int totalVotes;
  final String uid;
  final String username;

  PostModel copyWith({
    String category,
    String description,
    List<Option> options,
    String deviceId,
    String displayName,
    String email,
    String imageUrl,
    String photoUrl,
    String title,
    int totalVotes,
    String uid,
    String username,
  }) =>
      PostModel(
        category: category ?? this.category,
        description: description ?? this.description,
        options: options ?? this.options,
        deviceId: deviceId ?? this.deviceId,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
        photoUrl: photoUrl ?? this.photoUrl,
        title: title ?? this.title,
        totalVotes: totalVotes ?? this.totalVotes,
        uid: uid ?? this.uid,
        username: username ?? this.username,
      );

  factory PostModel.fromJson(String str) => PostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        category: json["category"],
        description: json["description"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromMap(x))),
        deviceId: json["deviceId"],
        displayName: json["displayName"],
        email: json["email"],
        imageUrl: json["imageUrl"],
        photoUrl: json["photoUrl"],
        title: json["title"],
        totalVotes: json["totalVotes"],
        uid: json["uid"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "category": category,
        "description": description,
        "options": List<dynamic>.from(options.map((x) => x.toMap())),
        "deviceId": deviceId,
        "displayName": displayName,
        "email": email,
        "imageUrl": imageUrl,
        "photoUrl": photoUrl,
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
