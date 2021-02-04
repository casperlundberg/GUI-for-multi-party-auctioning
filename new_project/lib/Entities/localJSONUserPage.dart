import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<String> getJson() async {
  return await rootBundle.loadString("../../JSON/LoginResponse.json");
}

Future<LocalJSONUserPage> get localJSONUserResponse async {
  String jsonString = await getJson();

  var userJson = json.decode(jsonString);
  LocalJSONUserPage user = userJson.map((data) => LocalJSONUserPage.fromJson(data)).toList();
  return user;
}

class LocalJSONUserPage {
  UserInfo userInfo;
  int statusCode;

  LocalJSONUserPage({
    this.userInfo,
    this.statusCode,
  });

  LocalJSONUserPage.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null ? new UserInfo.fromJson(json['userInfo']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class UserInfo {
  int userId;
  String userName;
  String email;
  int age;
  String currentType;

  UserInfo({
    this.userId,
    this.userName,
    this.email,
    this.age,
    this.currentType,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    age = json['age'];
    currentType = json['currentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['age'] = this.age;
    data['currentType'] = this.currentType;
    return data;
  }
}
