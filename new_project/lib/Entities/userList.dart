// To parse this JSON data, do
//
//     final localJsonUserList = localJsonUserListFromJson(jsonString);

import 'dart:convert';

import 'user.dart';

UserList userListFromJson(String str) => UserList.fromJson(json.decode(str));

String userListToJson(UserList data) => json.encode(data.toJson());

class UserList {
  UserList({
    this.users,
  });

  List<User> users;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
