// To parse this JSON data, do
//
//     final auctionDetailsList = auctionDetailsListFromJson(jsonString);

import 'dart:convert';
import '../Entities/templateListJSON.dart';

AuctionDetailsList auctionDetailsListFromJson(String str) => AuctionDetailsList.fromJson(json.decode(str));

String auctionDetailsListToJson(AuctionDetailsList data) => json.encode(data.toJson());

class AuctionDetailsList {
  AuctionDetailsList({
    this.auctionDetailsList,
  });

  List<AuctionDetails> auctionDetailsList;

  factory AuctionDetailsList.fromJson(Map<String, dynamic> json) => AuctionDetailsList(
        auctionDetailsList: List<AuctionDetails>.from(json["auctionDetailsList"].map((x) => AuctionDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "auctionDetailsList": List<dynamic>.from(auctionDetailsList.map((x) => x.toJson())),
      };
}

class AuctionDetails {
  AuctionDetails({
    this.id,
    this.participants,
    this.templateId,
    this.bids,
    this.winningBid,
  });

  int id;
  List<Participant> participants;
  int templateId;
  List<Bid> bids;
  int winningBid; //0 if not yet picked, -1 if there was no winner.

  factory AuctionDetails.fromJson(Map<String, dynamic> json) => AuctionDetails(
        id: json["id"],
        participants: List<Participant>.from(json["participants"].map((x) => Participant.fromJson(x))),
        templateId: json["templateID"],
        bids: List<Bid>.from(json["bids"].map((x) => Bid.fromJson(x))),
        winningBid: json["winningBid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
        "templateID": templateId,
        "bids": List<dynamic>.from(bids.map((x) => x.toJson())),
        "winningBid": winningBid,
      };
}

class Bid {
  Bid({
    this.id,
    this.time,
    this.userId,
    this.keyValuePairs,
  });

  int id;
  DateTime time;
  int userId;
  List<KeyValuePair> keyValuePairs;

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
        id: json["id"],
        time: DateTime.parse(json["time"]),
        userId: json["userID"],
        keyValuePairs: List<KeyValuePair>.from(json["keyValuePairs"].map((x) => KeyValuePair.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time.toIso8601String(),
        "userID": userId,
        "keyValuePairs": List<dynamic>.from(keyValuePairs.map((x) => x.toJson())),
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
