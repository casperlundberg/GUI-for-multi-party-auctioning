import 'dart:convert';
import 'dart:html';
//import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
//import 'package:flutter/foundation.dart';

Future<String> getJson() async {
  return await rootBundle.loadString("../../JSON/filters.json");
}

Future<List<LocalJSONFilter>> get getLocalJSONTest async {
  String arrayObjsText = await getJson();

  var filterJson = json.decode(arrayObjsText)['filters'] as List;
  List<LocalJSONFilter> filters = filterJson.map((data) => LocalJSONFilter.fromJson(data)).toList();
  return filters;
}

class LocalJSONFilter {
  final int id;
  int localid;
  int distance;
  final String name;
  final String description;

  LocalJSONFilter({
    this.id,
    this.name,
    this.description,
  });

  factory LocalJSONFilter.fromJson(Map<String, dynamic> json) {
    return new LocalJSONFilter(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
