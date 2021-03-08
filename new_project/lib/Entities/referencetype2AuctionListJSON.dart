// To parse this JSON data, do
//
//     final referencetype2AuctionList = referencetype2AuctionListFromJson(jsonString);

import 'dart:convert';

Referencetype2AuctionList referencetype2AuctionListFromJson(String str) => Referencetype2AuctionList.fromJson(json.decode(str));

String referencetype2AuctionListToJson(Referencetype2AuctionList data) => json.encode(data.toJson());

class Referencetype2AuctionList {
  Referencetype2AuctionList({
    this.referencetype2Auctions,
  });

  List<Referencetype2Auction> referencetype2Auctions;

  factory Referencetype2AuctionList.fromJson(Map<String, dynamic> json) => Referencetype2AuctionList(
        referencetype2Auctions: List<Referencetype2Auction>.from(json["referencetype2Auctions"].map((x) => Referencetype2Auction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "referencetype2Auctions": List<dynamic>.from(referencetype2Auctions.map((x) => x.toJson())),
      };
}

class Referencetype2Auction {
  Referencetype2Auction({
    this.id,
    this.title,
    this.ownerId,
    this.maxParticipants,
    this.currentParticipants,
    this.startDate,
    this.stopDate,
    this.referenceSector,
    this.referenceType,
    this.referencetype2ReferenceParameters,
  });

  int id;
  String title;
  int ownerId;
  int maxParticipants;
  int currentParticipants;
  DateTime startDate;
  DateTime stopDate;
  String referenceSector;
  String referenceType;
  Referencetype2ReferenceParameters referencetype2ReferenceParameters;

  factory Referencetype2Auction.fromJson(Map<String, dynamic> json) => Referencetype2Auction(
        id: json["id"],
        title: json["title"],
        ownerId: json["ownerID"],
        maxParticipants: json["maxParticipants"],
        currentParticipants: json["currentParticipants"],
        startDate: DateTime.parse(json["startDate"]),
        stopDate: DateTime.parse(json["stopDate"]),
        referenceSector: json["referenceSector"],
        referenceType: json["referenceType"],
        referencetype2ReferenceParameters: Referencetype2ReferenceParameters.fromJson(json["referencetype2ReferenceParameters"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "ownerID": ownerId,
        "maxParticipants": maxParticipants,
        "currentParticipants": currentParticipants,
        "startDate": startDate.toIso8601String(),
        "stopDate": stopDate.toIso8601String(),
        "referenceSector": referenceSector,
        "referenceType": referenceType,
        "referencetype2ReferenceParameters": referencetype2ReferenceParameters.toJson(),
      };
}

class Referencetype2ReferenceParameters {
  Referencetype2ReferenceParameters({
    this.parameter1,
    this.parameter2,
    this.minVolume,
    this.maxVolume,
  });

  String parameter1;
  String parameter2;
  int minVolume;
  int maxVolume;
  int localid;

  factory Referencetype2ReferenceParameters.fromJson(Map<String, dynamic> json) => Referencetype2ReferenceParameters(
        parameter1: json["parameter1"],
        parameter2: json["parameter2"],
        minVolume: json["minVolume"],
        maxVolume: json["maxVolume"],
      );

  Map<String, dynamic> toJson() => {
        "parameter1": parameter1,
        "parameter2": parameter2,
        "minVolume": minVolume,
        "maxVolume": maxVolume,
      };
}
