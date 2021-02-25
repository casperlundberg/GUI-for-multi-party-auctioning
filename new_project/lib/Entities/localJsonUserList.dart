// To parse this JSON data, do
//
//     final localJsonUserList = localJsonUserListFromJson(jsonString);

import 'dart:convert';
import 'localJSONUserPage.dart';

LocalJsonUserList localJsonUserListFromJson(String str) => LocalJsonUserList.fromJson(json.decode(str));

String localJsonUserListToJson(LocalJsonUserList data) => json.encode(data.toJson());

class LocalJsonUserList {
  LocalJsonUserList({
    this.users,
  });

  List<LocalJsonUserPage> users;

  factory LocalJsonUserList.fromJson(Map<String, dynamic> json) => LocalJsonUserList(
        users: List<LocalJsonUserPage>.from(json["users"].map((x) => LocalJsonUserPage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
