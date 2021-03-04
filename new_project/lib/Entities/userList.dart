// To parse this JSON data, do
//
//     final userList = userListFromJson(jsonString);

import 'dart:convert';

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
    this.offers,
    this.requestInbox,
    this.inviteInbox,
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
  List<Offer> offers;
  List<Inbox> requestInbox;
  List<Inbox> inviteInbox;

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
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
        requestInbox: List<Inbox>.from(json["requestInbox"].map((x) => Inbox.fromJson(x))),
        inviteInbox: List<Inbox>.from(json["inviteInbox"].map((x) => Inbox.fromJson(x))),
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
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
        "requestInbox": List<dynamic>.from(requestInbox.map((x) => x.toJson())),
        "inviteInbox": List<dynamic>.from(inviteInbox.map((x) => x.toJson())),
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

class Inbox {
  Inbox({
    this.time,
    this.status,
    this.auctionId,
    this.userId,
    this.offerId,
  });

  DateTime time;
  String status;
  int auctionId;
  int userId;
  int offerId;

  factory Inbox.fromJson(Map<String, dynamic> json) => Inbox(
        time: DateTime.parse(json["time"]),
        status: json["status"],
        auctionId: json["auctionID"],
        userId: json["userID"],
        offerId: json["offerID"] == null ? null : json["offerID"],
      );

  Map<String, dynamic> toJson() => {
        "time": time.toIso8601String(),
        "status": status,
        "auctionID": auctionId,
        "userID": userId,
        "offerID": offerId == null ? null : offerId,
      };
}

class Offer {
  Offer({
    this.offerId,
  });

  int offerId;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offerId: json["offerID"],
      );

  Map<String, dynamic> toJson() => {
        "offerID": offerId,
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
