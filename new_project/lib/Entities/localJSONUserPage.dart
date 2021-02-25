// To parse this JSON data, do
//
//     final localJsonUserPage = localJsonUserPageFromJson(jsonString);

import 'dart:convert';

LocalJsonUserPage localJsonUserPageFromJson(String str) => LocalJsonUserPage.fromJson(json.decode(str));

String localJsonUserPageToJson(LocalJsonUserPage data) => json.encode(data.toJson());

class LocalJsonUserPage {
  LocalJsonUserPage({
    this.userId,
    this.userName,
    this.email,
    this.password,
    this.age,
    this.address,
    this.homePhoneNumber,
    this.mobilePhoneNumber,
    this.officePhoneNumber,
    this.currentType,
  });

  int userId;
  String userName;
  String email;
  Password password;
  int age;
  Address address;
  String homePhoneNumber;
  String mobilePhoneNumber;
  String officePhoneNumber;
  String currentType;

  factory LocalJsonUserPage.fromJson(Map<String, dynamic> json) => LocalJsonUserPage(
        userId: json["userId"],
        userName: json["userName"],
        email: json["email"],
        password: Password.fromJson(json["password"]),
        age: json["age"],
        address: Address.fromJson(json["address"]),
        homePhoneNumber: json["homePhoneNumber"],
        mobilePhoneNumber: json["mobilePhoneNumber"],
        officePhoneNumber: json["officePhoneNumber"],
        currentType: json["currentType"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "email": email,
        "password": password.toJson(),
        "age": age,
        "address": address.toJson(),
        "homePhoneNumber": homePhoneNumber,
        "mobilePhoneNumber": mobilePhoneNumber,
        "officePhoneNumber": officePhoneNumber,
        "currentType": currentType,
      };
}

class Address {
  Address({
    this.streetAddress,
    this.city,
    this.state,
    this.postalCode,
  });

  String streetAddress;
  String city;
  String state;
  String postalCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        streetAddress: json["streetAddress"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postalCode"],
      );

  Map<String, dynamic> toJson() => {
        "streetAddress": streetAddress,
        "city": city,
        "state": state,
        "postalCode": postalCode,
      };
}

class Password {
  Password({
    this.type,
    this.encryption,
  });

  String type;
  String encryption;

  factory Password.fromJson(Map<String, dynamic> json) => Password(
        type: json["type"],
        encryption: json["encryption"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "encryption": encryption,
      };
}
