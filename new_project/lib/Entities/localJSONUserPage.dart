// To parse this JSON data, do
//
//     final localJsonUserPage = localJsonUserPageFromJson(jsonString);

import 'dart:convert';

LocalJsonUserPage localJsonUserPageFromJson(String str) => LocalJsonUserPage.fromJson(json.decode(str));

String localJsonUserPageToJson(LocalJsonUserPage data) => json.encode(data.toJson());

class LocalJsonUserPage {
  LocalJsonUserPage({
    this.userInfo,
    this.statusCode,
  });

  UserInfo userInfo;
  int statusCode;

  factory LocalJsonUserPage.fromJson(Map<String, dynamic> json) => LocalJsonUserPage(
        userInfo: UserInfo.fromJson(json["userInfo"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "userInfo": userInfo.toJson(),
        "statusCode": statusCode,
      };
}

class UserInfo {
  UserInfo({
    this.userId,
    this.userName,
    this.email,
    this.age,
    this.currentType,
  });

  int userId;
  String userName;
  String email;
  int age;
  String currentType;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        userId: json["userId"],
        userName: json["userName"],
        email: json["email"],
        age: json["age"],
        currentType: json["currentType"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "email": email,
        "age": age,
        "currentType": currentType,
      };
}
