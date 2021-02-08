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
    this.templateId,
    this.variables,
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
  int templateId;
  List<Variables> variables;
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
        templateId: json["templateID"],
        variables: List<Variables>.from(json["variables"].map((x) => Variables.fromJson(x))),
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
        "templateID": templateId,
        "variables": List<dynamic>.from(variables.map((x) => x.toJson())),
        "startDate": startDate.toIso8601String(),
        "stopDate": stopDate.toIso8601String(),
        "referenceSector": referenceSector,
        "referenceType": referenceType,
      };
}

class Variables {
  Variables({
    this.quantity,
    this.price,
  });

  String quantity;
  String price;

  factory Variables.fromJson(Map<String, dynamic> json) => Variables(
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "price": price,
      };
}
