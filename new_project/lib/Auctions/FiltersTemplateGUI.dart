//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'dart:async' show Future;
//import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class FilterTemplateGUI extends StatefulWidget {
  @override
  _FilterTemplateState createState() => _FilterTemplateState();
}

/* Future<List<Filter>> fetchFilters(http.Client client) async {
  final response = await client.get('REST-API_URL');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseFilters, response.body);
}

List<Filter> parseFilters(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Filter>((json) => Filter.fromJson(json)).toList();
}

class Filter {
  final int id;
  final String name;
  final String description;

  Filter({this.id, this.name, this.description});

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
} 

class FiltersList extends StatelessWidget {
  final List<Filter> filters;

  FiltersList({Key key, this.filters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: filters.length,
      itemBuilder: (context, index) {
        return Text(filters[index].name);
      },
    );
  }
}*/

/*
=====================
Local test for json handling
=====================
*/
List<LocalJSONFilter> getLocalJSONTest() {
  String arrayObjsText = '''
{"filters":[
    {
        "id": 1,
        "name": "Wood",
        "description": "test"
    },
    {
        "id": 2,
        "name": "Metals",
        "description": "test"
    },
    {
        "id": 3,
        "name": "Soil",
        "description": "test"
    }
]}
''';
  var filterJson = jsonDecode(arrayObjsText)['filters'] as List;
  List<LocalJSONFilter> filters = filterJson
      .map((filterJson) => LocalJSONFilter.fromJson(filterJson))
      .toList();
  return filters;
}

class LocalJSONFilter {
  final int id;
  final String name;
  final String description;

  LocalJSONFilter({this.id, this.name, this.description});

  factory LocalJSONFilter.fromJson(dynamic json) {
    return LocalJSONFilter(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

class _FilterTemplateState extends State<FilterTemplateGUI> {
  /* Future<List<Filter>> _getFilters() async {
    //var data = await http.get("API-URL");
    var data = json.decode(await getJson());
    var jsonData = json.decode(data.body);
    List<Filter> filters = [];
    for (var f in data) {
      Filter filter = Filter(f["id"], f["name"], f["description"]);
      filters.add(filter);
    }

    print(filters.length);

    return filters;
  } */
/*   Future<Filter> futureFilter; */

/*   @override
  void initState() {
    super.initState();
    futureFilter = fetchFilter();
  } */

  List<LocalJSONFilter> items;
  void initState() {
    super.initState();
    items = getLocalJSONTest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // ignore: deprecated_member_use
        child: RaisedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      /*
                      ====================
                      Pop-up widget information is put here
                      ====================
                      */
                      Center(
                        /* child: FutureBuilder<List<Filter>>(
                          future: fetchFilters(http.Client()),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);

                            return snapshot.hasData
                                ? FiltersList(filters: snapshot.data)
                                : Center(child: CircularProgressIndicator());
                          },
                        ), */
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('${items[index].name}'),
                            );
                          },
                        ),
                      ),
                    ],
                    clipBehavior: Clip.none,
                  ),
                );
              },
            );
          },
          child: Text("Add filters"),
        ),
      ),
    );
  }
}

//Get local json file - not sure how it works
/* Future<String> getJson() async {
  return await rootBundle.loadString('../../../JSON/categories.json');
}
 */
