import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Entities/filters.dart';

class FiltersGUI extends StatefulWidget {
  final List<Filter> availableFilters;
  final List<Filter> activeFilters;
  final List<Filter> inactiveFilters;
  final Function updateFilters;
  final Function deleteFilter;
  final Function activateFilter;
  final Function deactivateFilter;

  FiltersGUI(this.availableFilters, this.activeFilters, this.inactiveFilters, this.updateFilters, this.deleteFilter,
      this.activateFilter, this.deactivateFilter);

  @override
  _FiltersState createState() => _FiltersState(
      availableFilters, activeFilters, inactiveFilters, updateFilters, deleteFilter, activateFilter, deactivateFilter);
}

class _FiltersState extends State<FiltersGUI> {
  final List<Filter> availableFilters;
  List<Filter> activeFilters;
  List<Filter> inactiveFilters;
  final Function updateFilters;
  final Function deleteFilter;
  final Function activateFilter;
  final Function deactivateFilter;
  final myController = TextEditingController();
  Filter filter;

  _FiltersState(this.availableFilters, this.activeFilters, this.inactiveFilters, this.updateFilters, this.deleteFilter,
      this.activateFilter, this.deactivateFilter);

  void showFilterTemplateGUI() {
    if (filter == null) {
      filter = new Filter(
          id: availableFilters[0].id, name: availableFilters[0].name, description: availableFilters[0].description);
    }

    if (filter.distance != null) {
      myController.text = filter.distance.toString();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final ThemeData themeData = Theme.of(context);

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            color: themeData.primaryColor,
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
                    color: Colors.grey[900], //Couldn't import from theme as "Dialog" is transparent
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
                                if (availableFilters != null && availableFilters.length > 0) {
                                  String dropdownValue = filter.name;
                                  List<String> names = [];

                                  for (int i = 0; i < availableFilters.length; i++) {
                                    names.add(availableFilters[i].name);
                                  }
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('Material: '),
                                          DropdownButton(
                                            icon: Icon(Icons.arrow_downward),
                                            iconSize: 24,
                                            value: dropdownValue,
                                            elevation: 16,
                                            style: TextStyle(color: Colors.white),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                for (int i = 0; i < availableFilters.length; i++) {
                                                  if (availableFilters[i].name == newValue) {
                                                    int localid = filter.localid;
                                                    filter = new Filter(
                                                        id: availableFilters[i].id,
                                                        name: availableFilters[i].name,
                                                        description: availableFilters[i].description);
                                                    filter.localid = localid;
                                                    dropdownValue = newValue;
                                                  }
                                                }
                                              });
                                            },
                                            items: names.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                      Text('Description: ' + filter.description),
                                      Row(
                                        children: [
                                          Text('Distance: '),
                                          Expanded(
                                            child: TextField(
                                              controller: myController,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.digitsOnly
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                } else {
                                  return new Container();
                                }
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
                          child: Text("Add filter"),
                          onPressed: () {
                            filter.distance = int.parse(myController.text);
                            myController.clear();
                            //print("localid: " + filter.localid.toString());
                            updateFilters(filter);
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
                      myController.clear();
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
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    if ((activeFilters != null && activeFilters.length > 0) ||
        (inactiveFilters != null && inactiveFilters.length > 0)) {
      List<Filter> allfilters = [];
      allfilters.addAll(activeFilters);
      allfilters.addAll(inactiveFilters);

      return new Container(
        color: themeData.primaryColor,
        child: Column(
          children: <Widget>[
            Text(
              'FILTERS\n',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              width: 330,
              height: 720,
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: allfilters.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Container(
                          width: 320.0,
                          height: 110.0,
                          color: index >= activeFilters.length ? Colors.grey : Colors.blue,
                          margin: EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        filter = allfilters[index];
                                      });
                                      showFilterTemplateGUI();
                                    },
                                    child: Text('Edit'),
                                  ),
                                  ElevatedButton(
                                    onPressed: index >= activeFilters.length
                                        ? () {
                                            activateFilter(allfilters[index]);
                                          }
                                        : null,
                                    child: Text('Activate'),
                                  ),
                                  ElevatedButton(
                                    onPressed: index < activeFilters.length
                                        ? () {
                                            deactivateFilter(allfilters[index]);
                                          }
                                        : null,
                                    child: Text('Deactivate'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      deleteFilter(allfilters[index]);
                                    },
                                    child: Text('Delete'),
                                  ),
                                  Text('id: ' + allfilters[index].localid.toString()),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(''),
                                  Text(
                                    'Material: ' + allfilters[index].name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'Description: ' + allfilters[index].description,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Container(
              width: 330,
              height: 50,
              margin: EdgeInsets.all(5.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filter = null;
                    });
                    showFilterTemplateGUI();
                  },
                  child: Text('Add filter'),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      final ThemeData themeData = Theme.of(context);
      return new Container(
        color: themeData.primaryColor,
        child: Column(
          children: [
            Text(
              'FILTERS\n',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              width: 330,
              height: 720,
              child: Text(
                'No filters added yet.\n',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 330,
              height: 50,
              margin: EdgeInsets.all(5.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filter = null;
                    });
                    showFilterTemplateGUI();
                  },
                  child: Text('Add filter'),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
