import 'package:flutter/material.dart';

import '../Entities/localJSONFilter.dart';

class FilterTemplateGUI extends StatefulWidget {
  final List<LocalJSONFilter> filters;
  final Function updateFilters;
  FilterTemplateGUI(this.filters, this.updateFilters);

  @override
  _FilterTemplateState createState() =>
      _FilterTemplateState(filters, updateFilters);
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

class _FilterTemplateState extends State<FilterTemplateGUI> {
  List<LocalJSONFilter> filters;
  Function updateFilters;
  Future<List<LocalJSONFilter>> items;
  var selectedLocationIndices = Set<int>();

  _FilterTemplateState(List<LocalJSONFilter> filters, Function updateFilters) {
    for (int i = 0; i < filters.length; i++) {
      this.selectedLocationIndices.add(filters[i].id);
    }
    this.filters = filters;
    this.updateFilters = updateFilters;
  }

  void initState() {
    super.initState();
    items = getLocalJSONTest;
  }

  void toggleSelectedFilter(LocalJSONFilter filter) {
    if (selectedLocationIndices.contains(filter.id)) {
      selectedLocationIndices.remove(filter.id);
      for (int i = 0; i < filters.length; i++) {
        if (filters[i].id == filter.id) {
          filters.removeAt(i);
        }
      }
    } else {
      selectedLocationIndices.add(filter.id);
      filters.add(filter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: 400,
                    margin: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 18.0,
                          ),
                          margin: EdgeInsets.only(top: 13.0, right: 8.0),
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            color: Colors.grey[
                                900], //Couldn't import from theme as "Dialog" is transparent
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 0.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 20.0,
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  /*
                                  ====================
                                  Filters are listed below
                                  ====================
                                  */
                                  child: new Container(
                                    width: 400,
                                    height: 300,
                                    child: StatefulBuilder(
                                      builder: (context, setState) {
                                        return FutureBuilder<
                                            List<LocalJSONFilter>>(
                                          future: items,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError)
                                              return new Text(
                                                  'Error: ${snapshot.error}');
                                            else {
                                              List<LocalJSONFilter> values =
                                                  snapshot.data;
                                              if (values != null &&
                                                  values.length > 0) {
                                                return new Scrollbar(
                                                  child: new RefreshIndicator(
                                                    onRefresh: _handleRefresh,
                                                    child: ListView.builder(
                                                      itemCount: values.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return new Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            new Container(
                                                              color: selectedLocationIndices
                                                                      .contains(
                                                                          values[index]
                                                                              .id)
                                                                  ? Colors.blue
                                                                  : Colors
                                                                      .transparent,
                                                              child: ListTile(
                                                                onTap: () {
                                                                  toggleSelectedFilter(
                                                                      values[
                                                                          index]);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                title: new Text(
                                                                  values[index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                subtitle:
                                                                    new Text(
                                                                  values[index]
                                                                      .description,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
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
                                ),
                              ),
                              /*
                              ====================
                              Bottombutton
                              ====================
                              */
                              SizedBox(height: 24.0),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ElevatedButton(
                                  child: Text("Add selected filters"),
                                  onPressed: () {
                                    updateFilters(filters);
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        /*
                        ====================
                        Exitbutton
                        ====================
                        */
                        Positioned(
                          right: 0.0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                radius: 14.0,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.close, color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

  //Should call for the API-get function to update the filterlist, better be using auto-update from httprequest on API tho.
  //Depending on the API, this may be unneccessary as it does nothing.
  //Dont know if this setState() reruns initState due to its parents mechanics.
  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 1));

    setState(() {});

    return null;
  }
}
