import 'dart:convert';

Filters filtersFromJson(String str) => Filters.fromJson(json.decode(str));

String filtersToJson(Filters data) => json.encode(data.toJson());

class Filters {
  Filters({
    this.filters,
  });

  List<Filter> filters;

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        filters: List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
      };
}

class Filter {
  Filter({
    this.id,
    this.name,
    this.description,
  });

  int id;
  int localid;
  int distance;
  String name;
  String description;

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
