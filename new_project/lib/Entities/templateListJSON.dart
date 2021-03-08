// To parse this JSON data, do
//
//     final templateList = templateListFromJson(jsonString);

import 'dart:convert';

TemplateList templateListFromJson(String str) => TemplateList.fromJson(json.decode(str));

String templateListToJson(TemplateList data) => json.encode(data.toJson());

class TemplateList {
  TemplateList({
    this.templates,
  });

  List<Template> templates;

  factory TemplateList.fromJson(Map<String, dynamic> json) => TemplateList(
        templates: List<Template>.from(json["templates"].map((x) => Template.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "templates": List<dynamic>.from(templates.map((x) => x.toJson())),
      };
}

class Template {
  Template({
    this.id,
    this.templateStrings,
    this.templateVariables,
  });

  int id;
  List<TemplateString> templateStrings;
  List<TemplateVariable> templateVariables;

  factory Template.fromJson(Map<String, dynamic> json) => Template(
        id: json["id"],
        templateStrings: List<TemplateString>.from(json["templateStrings"].map((x) => TemplateString.fromJson(x))),
        templateVariables: List<TemplateVariable>.from(json["templateVariables"].map((x) => TemplateVariable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "templateStrings": List<dynamic>.from(templateStrings.map((x) => x.toJson())),
        "templateVariables": List<dynamic>.from(templateVariables.map((x) => x.toJson())),
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
