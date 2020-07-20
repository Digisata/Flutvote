import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
    UserModel({
        @required this.username,
        @required this.email,
        @required this.displayName,
    });

    final String username;
    final String email;
    final String displayName;

    UserModel copyWith({
        String username,
        String email,
        String displayName,
    }) => 
        UserModel(
            username: username ?? this.username,
            email: email ?? this.email,
            displayName: displayName ?? this.displayName,
        );

    factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        email: json["email"],
        displayName: json["displayName"],
    );

    Map<String, dynamic> toMap() => {
        "username": username,
        "email": email,
        "displayName": displayName,
    };
}