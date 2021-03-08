// To parse this JSON data, do
//
//     final materialOfferList = materialOfferListFromJson(jsonString);

import 'dart:convert';
import '../Entities/materialAuctionListJSON.dart';

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
        startDate: DateTime.parse(json["startDate"]),
        stopDate: DateTime.parse(json["stopDate"]),
        referenceSector: json["referenceSector"],
        referenceType: json["referenceType"],
        materialReferenceParameters: MaterialReferenceParameters.fromJson(json["materialReferenceParameters"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "userID": userId,
        "templateID": templateId,
        "startDate": startDate.toIso8601String(),
        "stopDate": stopDate.toIso8601String(),
        "referenceSector": referenceSector,
        "referenceType": referenceType,
        "materialReferenceParameters": materialReferenceParameters.toJson(),
      };
}
