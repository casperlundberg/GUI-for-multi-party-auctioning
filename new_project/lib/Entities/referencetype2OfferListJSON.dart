// To parse this JSON data, do
//
//     final referencetype2OfferList = referencetype2OfferListFromJson(jsonString);

import 'dart:convert';
import '../Entities/referencetype2AuctionListJSON.dart';

Referencetype2OfferList referencetype2OfferListFromJson(String str) => Referencetype2OfferList.fromJson(json.decode(str));

String referencetype2OfferListToJson(Referencetype2OfferList data) => json.encode(data.toJson());

class Referencetype2OfferList {
  Referencetype2OfferList({
    this.referencetype2Offers,
  });

  List<Referencetype2Offer> referencetype2Offers;

  factory Referencetype2OfferList.fromJson(Map<String, dynamic> json) => Referencetype2OfferList(
        referencetype2Offers: List<Referencetype2Offer>.from(json["referencetype2Offers"].map((x) => Referencetype2Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "referencetype2Offers": List<dynamic>.from(referencetype2Offers.map((x) => x.toJson())),
      };
}

class Referencetype2Offer {
  Referencetype2Offer({
    this.id,
    this.title,
    this.userId,
    this.templateId,
    this.startDate,
    this.stopDate,
    this.referenceSector,
    this.referenceType,
    this.referencetype2ReferenceParameters,
  });

  int id;
  String title;
  int userId;
  int templateId;
  DateTime startDate;
  DateTime stopDate;
  String referenceSector;
  String referenceType;
  Referencetype2ReferenceParameters referencetype2ReferenceParameters;

  factory Referencetype2Offer.fromJson(Map<String, dynamic> json) => Referencetype2Offer(
        id: json["id"],
        title: json["title"],
        userId: json["userID"],
        templateId: json["templateID"],
        startDate: DateTime.parse(json["startDate"]),
        stopDate: DateTime.parse(json["stopDate"]),
        referenceSector: json["referenceSector"],
        referenceType: json["referenceType"],
        referencetype2ReferenceParameters: Referencetype2ReferenceParameters.fromJson(json["referenceParameters"]),
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
        "referenceParameters": referencetype2ReferenceParameters.toJson(),
      };
}
