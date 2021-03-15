// To parse this JSON data, do
//
//     final filters = filtersFromJson(jsonString);

import 'dart:convert';

Filters filtersFromJson(String str) => Filters.fromJson(json.decode(str));

String filtersToJson(Filters data) => json.encode(data.toJson());

class Filters {
  Filters({
    this.referenceSectors,
  });

  List<ReferenceSector> referenceSectors;

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        referenceSectors: List<ReferenceSector>.from(json["referenceSectors"].map((x) => ReferenceSector.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "referenceSectors": List<dynamic>.from(referenceSectors.map((x) => x.toJson())),
      };
}

class ReferenceSector {
  ReferenceSector({
    this.name,
    this.referenceTypes,
  });

  String name;
  List<ReferenceType> referenceTypes;

  factory ReferenceSector.fromJson(Map<String, dynamic> json) => ReferenceSector(
        name: json["name"],
        referenceTypes: List<ReferenceType>.from(json["referenceTypes"].map((x) => ReferenceType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "referenceTypes": List<dynamic>.from(referenceTypes.map((x) => x.toJson())),
      };
}

class ReferenceType {
  ReferenceType({
    this.name,
    this.referenceParameters,
    this.rangeReferenceParameters,
  });

  String name;
  List<ReferenceParameter> referenceParameters;
  List<RangeReferenceParameter> rangeReferenceParameters;

  factory ReferenceType.fromJson(Map<String, dynamic> json) => ReferenceType(
        name: json["name"],
        referenceParameters: List<ReferenceParameter>.from(json["referenceParameters"].map((x) => ReferenceParameter.fromJson(x))),
        rangeReferenceParameters: List<RangeReferenceParameter>.from(json["rangeReferenceParameters"].map((x) => RangeReferenceParameter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "referenceParameters": List<dynamic>.from(referenceParameters.map((x) => x.toJson())),
        "rangeReferenceParameters": List<dynamic>.from(rangeReferenceParameters.map((x) => x.toJson())),
      };
}

class RangeReferenceParameter {
  RangeReferenceParameter({
    this.name,
  });

  String name;

  factory RangeReferenceParameter.fromJson(Map<String, dynamic> json) => RangeReferenceParameter(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class ReferenceParameter {
  ReferenceParameter({
    this.name,
    this.values,
  });

  String name;
  List<FilterValue> values;

  factory ReferenceParameter.fromJson(Map<String, dynamic> json) => ReferenceParameter(
        name: json["name"],
        values: List<FilterValue>.from(json["values"].map((x) => FilterValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
      };
}

class FilterValue {
  FilterValue({
    this.filterValue,
  });

  String filterValue;

  factory FilterValue.fromJson(Map<String, dynamic> json) => FilterValue(
        filterValue: json["filterValue"],
      );

  Map<String, dynamic> toJson() => {
        "filterValue": filterValue,
      };
}
