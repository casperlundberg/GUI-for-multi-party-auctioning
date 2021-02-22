// To parse this JSON data, do
//
//     final auctionDetails = auctionDetailsFromJson(jsonString);

import 'dart:convert';

AuctionDetails auctionDetailsFromJson(String str) => AuctionDetails.fromJson(json.decode(str));

String auctionDetailsToJson(AuctionDetails data) => json.encode(data.toJson());

class AuctionDetails {
  AuctionDetails({
    this.id,
    this.title,
    this.ownerId,
    this.ownerType,
    this.maxParticipants,
    this.currentParticipants,
    this.roundTime,
    this.material,
    this.templateStrings,
    this.templateVariables,
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
  int currentParticipants;
  int roundTime;
  String material;
  List<TemplateString> templateStrings;
  List<TemplateVariable> templateVariables;
  List<Bid> bids;
  DateTime startDate;
  DateTime stopDate;
  String referenceSector;
  String referenceType;

  factory AuctionDetails.fromJson(Map<String, dynamic> json) => AuctionDetails(
        id: json["id"],
        title: json["title"],
        ownerId: json["ownerID"],
        ownerType: json["ownerType"],
        maxParticipants: json["maxParticipants"],
        currentParticipants: json["currentParticipants"],
        roundTime: json["roundTime"],
        material: json["material"],
        templateStrings: List<TemplateString>.from(json["templateStrings"].map((x) => TemplateString.fromJson(x))),
        templateVariables: List<TemplateVariable>.from(json["templateVariables"].map((x) => TemplateVariable.fromJson(x))),
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
        "currentParticipants": currentParticipants,
        "roundTime": roundTime,
        "material": material,
        "templateStrings": List<dynamic>.from(templateStrings.map((x) => x.toJson())),
        "templateVariables": List<dynamic>.from(templateVariables.map((x) => x.toJson())),
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
    this.keyValuePairs,
  });

  int userId;
  List<KeyValuePair> keyValuePairs;

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
        userId: json["userID"],
        keyValuePairs: List<KeyValuePair>.from(json["keyValuePairs"].map((x) => KeyValuePair.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
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

class TemplateString {
  TemplateString({
    this.text,
  });

  String text;

  factory TemplateString.fromJson(Map<String, dynamic> json) => TemplateString(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}

class TemplateVariable {
  TemplateVariable({
    this.key,
    this.valueType,
  });

  String key;
  String valueType;

  factory TemplateVariable.fromJson(Map<String, dynamic> json) => TemplateVariable(
        key: json["key"],
        valueType: json["valueType"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "valueType": valueType,
      };
}
