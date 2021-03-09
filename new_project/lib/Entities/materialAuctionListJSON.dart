// To parse this JSON data, do
//
//     final materialAuctionList = materialAuctionListFromJson(jsonString);

import 'dart:convert';

MaterialAuctionList materialAuctionListFromJson(String str) => MaterialAuctionList.fromJson(json.decode(str));

String materialAuctionListToJson(MaterialAuctionList data) => json.encode(data.toJson());

class MaterialAuctionList {
  MaterialAuctionList({
    this.materialAuctions,
  });

  List<MaterialAuction> materialAuctions;

  factory MaterialAuctionList.fromJson(Map<String, dynamic> json) => MaterialAuctionList(
        materialAuctions: List<MaterialAuction>.from(json["materialAuctions"].map((x) => MaterialAuction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "materialAuctions": List<dynamic>.from(materialAuctions.map((x) => x.toJson())),
      };
}

class MaterialAuction {
  MaterialAuction({
    this.id,
    this.title,
    this.ownerId,
    this.maxParticipants,
    this.currentParticipants,
    this.startDate,
    this.stopDate,
    this.referenceSector,
    this.referenceType,
    this.materialReferenceParameters,
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
  MaterialReferenceParameters materialReferenceParameters;

  factory MaterialAuction.fromJson(Map<String, dynamic> json) => MaterialAuction(
        id: json["id"],
        title: json["title"],
        ownerId: json["ownerID"],
        maxParticipants: json["maxParticipants"],
        currentParticipants: json["currentParticipants"],
        startDate: DateTime.parse(json["startDate"]),
        stopDate: DateTime.parse(json["stopDate"]),
        referenceSector: json["referenceSector"],
        referenceType: json["referenceType"],
        materialReferenceParameters: MaterialReferenceParameters.fromJson(json["materialReferenceParameters"]),
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
        "materialReferenceParameters": materialReferenceParameters.toJson(),
      };
}

class MaterialReferenceParameters {
  MaterialReferenceParameters({
    this.fibersType,
    this.resinType,
    this.minFiberLength,
    this.maxFiberLength,
    this.recyclingTechnology,
    this.sizing,
    this.additives,
    this.minVolume,
    this.maxVolume,
  });

  String fibersType;
  String resinType;
  int minFiberLength;
  int maxFiberLength;
  String recyclingTechnology;
  String sizing;
  String additives;
  int minVolume;
  int maxVolume;
  int localid; // Used for local filtering.

  factory MaterialReferenceParameters.fromJson(Map<String, dynamic> json) => MaterialReferenceParameters(
        fibersType: json["fibersType"],
        resinType: json["resinType"],
        minFiberLength: json["minFiberLength"],
        maxFiberLength: json["maxFiberLength"],
        recyclingTechnology: json["recyclingTechnology"],
        sizing: json["sizing"],
        additives: json["additives"],
        minVolume: json["minVolume"],
        maxVolume: json["maxVolume"],
      );

  Map<String, dynamic> toJson() => {
        "fibersType": fibersType,
        "resinType": resinType,
        "minFiberLength": minFiberLength,
        "maxFiberLength": maxFiberLength,
        "recyclingTechnology": recyclingTechnology,
        "sizing": sizing,
        "additives": additives,
        "minVolume": minVolume,
        "maxVolume": maxVolume,
      };
}
