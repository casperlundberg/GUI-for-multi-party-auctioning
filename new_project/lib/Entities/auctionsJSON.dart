// To parse this JSON data, do
//
//     final auctions = auctionsFromJson(jsonString);

import 'dart:convert';

Auctions auctionsFromJson(String str) => Auctions.fromJson(json.decode(str));

String auctionsToJson(Auctions data) => json.encode(data.toJson());

class Auctions {
  Auctions({
    this.auctions,
  });

  List<Auction> auctions;

  factory Auctions.fromJson(Map<String, dynamic> json) => Auctions(
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
    this.owner,
    this.stopDate,
    this.referenceSector,
    this.referenceType,
  });

  int id;
  String title;
  String owner;
  DateTime stopDate;
  String referenceSector;
  String referenceType;

  factory Auction.fromJson(Map<String, dynamic> json) => Auction(
        id: json["id"],
        title: json["title"],
        owner: json["owner"],
        stopDate: DateTime.parse(json["stopDate"]),
        referenceSector: json["referenceSector"],
        referenceType: json["referenceType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "owner": owner,
        "stopDate": stopDate.toIso8601String(),
        "referenceSector": referenceSector,
        "referenceType": referenceType,
      };
}
