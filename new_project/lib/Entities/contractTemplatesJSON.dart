// To parse this JSON data, do
//
//     final contractTemplates = contractTemplatesFromJson(jsonString);

import 'dart:convert';

ContractTemplates contractTemplatesFromJson(String str) => ContractTemplates.fromJson(json.decode(str));

String contractTemplatesToJson(ContractTemplates data) => json.encode(data.toJson());

class ContractTemplates {
  ContractTemplates({
    this.contractTemplates,
  });

  List<ContractTemplate> contractTemplates;

  factory ContractTemplates.fromJson(Map<String, dynamic> json) => ContractTemplates(
        contractTemplates: List<ContractTemplate>.from(json["contractTemplates"].map((x) => ContractTemplate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contractTemplates": List<dynamic>.from(contractTemplates.map((x) => x.toJson())),
      };
}

class ContractTemplate {
  ContractTemplate({
    this.id,
    this.templateStrings,
    this.templateVariables,
  });

  int id;
  List<TemplateString> templateStrings;
  List<TemplateVariable> templateVariables;

  factory ContractTemplate.fromJson(Map<String, dynamic> json) => ContractTemplate(
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
