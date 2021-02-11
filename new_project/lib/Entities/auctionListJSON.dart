// To parse this JSON data, do
//
//     final auctionList = auctionListFromJson(jsonString);

import 'dart:convert';

AuctionList auctionListFromJson(String str) => AuctionList.fromJson(json.decode(str));

String auctionListToJson(AuctionList data) => json.encode(data.toJson());

class AuctionList {
  AuctionList({
    this.auctionList,
  });

  List<Auction> auctionList;

  factory AuctionList.fromJson(Map<String, dynamic> json) => AuctionList(
        auctionList: List<Auction>.from(json["auctionList"].map((x) => Auction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "auctionList": List<dynamic>.from(auctionList.map((x) => x.toJson())),
      };
}

class Auction {
  Auction({
    this.id,
    this.title,
    this.ownerId,
    this.ownerType,
    this.maxParticipants,
    this.currentParticipants,
    this.roundTime,
    this.material,
    this.startDate,
    this.stopDate,
    this.referenceSector,
    this.referenceType,
  });

  int id;
  String title;
  int ownerId;
  String ownerType;
  int maxParticipants;
  int currentParticipants;
  int roundTime;
  String material;
  DateTime startDate;
  DateTime stopDate;
  String referenceSector;
  String referenceType;

  factory Auction.fromJson(Map<String, dynamic> json) => Auction(
        id: json["id"],
        title: json["title"],
        ownerId: json["ownerID"],
        ownerType: json["ownerType"],
        maxParticipants: json["maxParticipants"],
        currentParticipants: json["currentParticipants"],
        roundTime: json["roundTime"],
        material: json["material"],
        startDate: DateTime.parse(json["startDate"]),
        stopDate: DateTime.parse(json["stopDate"]),
        referenceSector: json["referenceSector"],
        referenceType: json["referenceType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "ownerID": ownerId,
        "ownerType": ownerType,
        "maxParticipants": maxParticipants,
        "currentParticipants": currentParticipants,
        "roundTime": roundTime,
        "material": material,
        "startDate": startDate.toIso8601String(),
        "stopDate": stopDate.toIso8601String(),
        "referenceSector": referenceSector,
        "referenceType": referenceType,
      };
}
