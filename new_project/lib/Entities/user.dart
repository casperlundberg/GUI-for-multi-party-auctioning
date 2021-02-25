// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
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
    this.company,
    this.participatingAuctions,
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
  String company;
  List<ParticipatingAuction> participatingAuctions;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        company: json["company"],
        participatingAuctions: List<ParticipatingAuction>.from(json["participatingAuctions"].map((x) => ParticipatingAuction.fromJson(x))),
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
        "company": company,
        "participatingAuctions": List<dynamic>.from(participatingAuctions.map((x) => x.toJson())),
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

class ParticipatingAuction {
  ParticipatingAuction({
    this.auctionId,
  });

  int auctionId;

  factory ParticipatingAuction.fromJson(Map<String, dynamic> json) => ParticipatingAuction(
        auctionId: json["auctionID"],
      );

  Map<String, dynamic> toJson() => {
        "auctionID": auctionId,
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
