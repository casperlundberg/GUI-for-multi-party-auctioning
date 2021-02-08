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
    this.owner,
    this.stopDate,
    this.referenceSector,
    this.referenceType,
    this.parameters,
  });

  int id;
  String title;
  String owner;
  DateTime stopDate;
  String referenceSector;
  String referenceType;
  Parameters parameters;

  factory AuctionDetails.fromJson(Map<String, dynamic> json) => AuctionDetails(
        id: json["id"],
        title: json["title"],
        owner: json["owner"],
        stopDate: DateTime.parse(json["stopDate"]),
        referenceSector: json["referenceSector"],
        referenceType: json["referenceType"],
        parameters: Parameters.fromJson(json["parameters"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "owner": owner,
        "stopDate": stopDate.toIso8601String(),
        "referenceSector": referenceSector,
        "referenceType": referenceType,
        "parameters": parameters.toJson(),
      };
}

class Parameters {
  Parameters({
    this.quantity,
    this.weight,
    this.length,
  });

  int quantity;
  String weight;
  String length;

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
        quantity: json["quantity"],
        weight: json["weight"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "weight": weight,
        "length": length,
      };
}
