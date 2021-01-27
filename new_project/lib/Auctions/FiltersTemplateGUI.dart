//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
//import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
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
============================
Local test for json handling
============================
*/
Future<String> getJson() async {
  return await rootBundle.loadString("../../JSON/filters.json");
}

Future<List<LocalJSONFilter>> get getLocalJSONTest async {
  String arrayObjsText = await getJson();

  var filterJson = json.decode(arrayObjsText)['filters'] as List;
  List<LocalJSONFilter> filters =
      filterJson.map((data) => LocalJSONFilter.fromJson(data)).toList();
  return filters;
}

class LocalJSONFilter {
  final int id;
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

class _FilterTemplateState extends State<FilterTemplateGUI> {
  Future<List<LocalJSONFilter>> items;
  var selectedLocationIndices = Set<int>();

  void initState() {
    super.initState();
    items = getLocalJSONTest;
  }

  void toggleSelectedFilter(int index) {
    if (selectedLocationIndices.contains(index))
      selectedLocationIndices.remove(index);
    else
      selectedLocationIndices.add(index);
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
                      SizedBox(
                        width: 400.0,
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return FutureBuilder<List<LocalJSONFilter>>(
                              future: items,
                              builder: (context, snapshot) {
                                if (snapshot.hasError)
                                  return new Text('Error: ${snapshot.error}');
                                else {
                                  List<LocalJSONFilter> values = snapshot.data;
                                  if (values != null && values.length > 0) {
                                    return new Scrollbar(
                                      child: new RefreshIndicator(
                                        onRefresh: _handleRefresh,
                                        child: ListView.builder(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: values.length,
                                          itemBuilder: (context, index) {
                                            return new Column(
                                              children: <Widget>[
                                                new Container(
                                                  //color: values[index].selected ? Colors.blue : Colors.orange,
                                                  color: selectedLocationIndices
                                                          .contains(index)
                                                      ? Colors.transparent
                                                      : Colors.blue,
                                                  child: ListTile(
                                                    onTap: () {
                                                      toggleSelectedFilter(
                                                          index);
                                                      setState(() {});
                                                    },
                                                    title: new Text(
                                                      values[index].name,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    subtitle: new Text(
                                                      values[index].description,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                new Divider(
                                                  height: 2.0,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  } else {
                                    return new Container();
                                  }
                                }
                              },
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

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 1));

    setState(() {});

    return null;
  }
}
