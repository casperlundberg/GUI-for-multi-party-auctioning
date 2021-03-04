// To parse this JSON data, do
//
//     final auctionDetailsList = auctionDetailsListFromJson(jsonString);

import 'dart:convert';

import 'contractTemplatesJSON.dart';

AuctionDetailsList auctionDetailsListFromJson(String str) =>
    AuctionDetailsList.fromJson(json.decode(str));

String auctionDetailsListToJson(AuctionDetailsList data) =>
    json.encode(data.toJson());

class AuctionDetailsList {
  AuctionDetailsList({
    this.auctionDetailsList,
  });

  List<AuctionDetails> auctionDetailsList;

  factory AuctionDetailsList.fromJson(Map<String, dynamic> json) =>
      AuctionDetailsList(
        auctionDetailsList: List<AuctionDetails>.from(
            json["auctionDetailsList"].map((x) => AuctionDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "auctionDetailsList":
            List<dynamic>.from(auctionDetailsList.map((x) => x.toJson())),
      };
}

class AuctionDetails {
  AuctionDetails({
    this.id,
    this.title,
    this.ownerId,
    this.ownerType,
    this.maxParticipants,
    this.participants,
    this.roundTime,
    this.material,
    this.contractTemplateId,
    this.bids,
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
  List<Participant> participants;
  int roundTime;
  String material;
  int contractTemplateId;
  List<Bid> bids;
  DateTime startDate;
  DateTime stopDate;
  String referenceSector;
  String referenceType;
  ContractTemplate contractTemplate;

  factory AuctionDetails.fromJson(Map<String, dynamic> json) => AuctionDetails(
        id: json["id"],
        title: json["title"],
        ownerId: json["ownerID"],
        ownerType: json["ownerType"],
        maxParticipants: json["maxParticipants"],
        participants: List<Participant>.from(
            json["participants"].map((x) => Participant.fromJson(x))),
        roundTime: json["roundTime"],
        material: json["material"],
        contractTemplateId: json["contractTemplateID"],
        bids: List<Bid>.from(json["bids"].map((x) => Bid.fromJson(x))),
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
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
        "roundTime": roundTime,
        "material": material,
        "contractTemplateID": contractTemplateId,
        "bids": List<dynamic>.from(bids.map((x) => x.toJson())),
        "startDate": startDate.toIso8601String(),
        "stopDate": stopDate.toIso8601String(),
        "referenceSector": referenceSector,
        "referenceType": referenceType,
      };
}

class Bid {
  Bid({
    this.userId,
    this.time,
    this.keyValuePairs,
  });

  int userId;
  DateTime time;
  List<KeyValuePair> keyValuePairs;

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
        userId: json["userID"],
        time: DateTime.parse(json["time"]),
        keyValuePairs: List<KeyValuePair>.from(
            json["keyValuePairs"].map((x) => KeyValuePair.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "time": time.toIso8601String(),
        "keyValuePairs":
            List<dynamic>.from(keyValuePairs.map((x) => x.toJson())),
      };
}

class KeyValuePair {
  KeyValuePair({
    this.key,
    this.value,
  });

  String key;
  dynamic value;

  factory KeyValuePair.fromJson(Map<String, dynamic> json) => KeyValuePair(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class Participant {
  Participant({
    this.userId,
  });

  int userId;

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        userId: json["userID"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
      };
}
