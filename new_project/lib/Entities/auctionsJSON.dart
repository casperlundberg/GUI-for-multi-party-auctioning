// To parse this JSON data, do
//
//     final auctions = auctionsFromJson(jsonString);

import 'dart:convert';

AuctionsJSON auctionsFromJson(String str) => AuctionsJSON.fromJson(json.decode(str));

String auctionsToJson(AuctionsJSON data) => json.encode(data.toJson());

class AuctionsJSON {
  AuctionsJSON({
    this.auctions,
  });

  List<Auction> auctions;

  factory AuctionsJSON.fromJson(Map<String, dynamic> json) => AuctionsJSON(
        auctions: List<Auction>.from(json["auctions"].map((x) => Auction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "auctions": List<dynamic>.from(auctions.map((x) => x.toJson())),
      };
}

class Auction {
  Auction({
    this.id,
    this.title,
    this.ownerID,
    this.ownerType,
    this.stopDate,
    this.referenceSector,
    this.referenceType,
  });

  int id;
  String title;
  int ownerID;
  String ownerType;
  DateTime stopDate;
  String referenceSector;
  String referenceType;

  factory Auction.fromJson(Map<String, dynamic> json) => Auction(
        id: json["id"],
        title: json["title"],
        ownerID: json["ownerID"],
        ownerType: json["ownerType"],
        stopDate: DateTime.parse(json["stopDate"]),
        referenceSector: json["referenceSector"],
        referenceType: json["referenceType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "ownerID": ownerID,
        "ownerType": ownerType,
        "stopDate": stopDate.toIso8601String(),
        "referenceSector": referenceSector,
        "referenceType": referenceType,
      };
}
