// To parse this JSON data, do
//
//     final materialOfferList = materialOfferListFromJson(jsonString);

import 'dart:convert';
import '../Entities/materialAuctionListJSON.dart';
import '../Entities/auctionDetailsListJSON.dart';

MaterialOfferList materialOfferListFromJson(String str) => MaterialOfferList.fromJson(json.decode(str));

String materialOfferListToJson(MaterialOfferList data) => json.encode(data.toJson());

class MaterialOfferList {
  MaterialOfferList({
    this.materialOffers,
  });

  List<MaterialOffer> materialOffers;

  factory MaterialOfferList.fromJson(Map<String, dynamic> json) => MaterialOfferList(
        materialOffers: List<MaterialOffer>.from(json["materialOffers"].map((x) => MaterialOffer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "materialOffers": List<dynamic>.from(materialOffers.map((x) => x.toJson())),
      };
}

class MaterialOffer {
  MaterialOffer({
    this.id,
    this.title,
    this.userId,
    this.templateId,
    this.keyValuePairs,
    this.startDate,
    this.stopDate,
    this.referenceSector,
    this.referenceType,
    this.materialReferenceParameters,
  });

  int id;
  String title;
  int userId;
  int templateId;
  List<KeyValuePair> keyValuePairs;
  DateTime startDate;
  DateTime stopDate;
  String referenceSector;
  String referenceType;
  MaterialReferenceParameters materialReferenceParameters;

  factory MaterialOffer.fromJson(Map<String, dynamic> json) => MaterialOffer(
        id: json["id"],
        title: json["title"],
        userId: json["userID"],
        templateId: json["templateID"],
        keyValuePairs: json["keyValuePairs"] == null ? null : List<KeyValuePair>.from(json["keyValuePairs"].map((x) => KeyValuePair.fromJson(x))),
        startDate: DateTime.parse(json["startDate"]),
        stopDate: DateTime.parse(json["stopDate"]),
        referenceSector: json["referenceSector"],
        referenceType: json["referenceType"],
        materialReferenceParameters: MaterialReferenceParameters.fromJson(json["referenceParameters"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "userID": userId,
        "templateID": templateId,
        "keyValuePairs": keyValuePairs == null ? null : List<dynamic>.from(keyValuePairs.map((x) => x.toJson())),
        "startDate": startDate.toIso8601String(),
        "stopDate": stopDate.toIso8601String(),
        "referenceSector": referenceSector,
        "referenceType": referenceType,
        "referenceParameters": materialReferenceParameters.toJson(),
      };
}
