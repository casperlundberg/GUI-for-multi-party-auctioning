import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Handlers/filterHandler.dart';
import '../Entities/filtersJSON.dart';

class FiltersGUI extends StatefulWidget {
  final FilterHandler filterHandler;

  FiltersGUI(this.filterHandler);

  @override
  _FiltersState createState() => _FiltersState(filterHandler);
}

class _FiltersState extends State<FiltersGUI> {
  final FilterHandler filterHandler;
  final myController = TextEditingController();

  _FiltersState(this.filterHandler);
/*
  void showFilterTemplateGUI() {
    if (filter == null) {
      filter = new Filter(
          id: filterHandler.availableFilters[0].id, name: filterHandler.availableFilters[0].name, description: filterHandler.availableFilters[0].description);
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
            width: MediaQuery.of(context).size.width * 0.2,
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
                                if (filterHandler.availableFilters != null && filterHandler.availableFilters.length > 0) {
                                  String dropdownValue = filter.name;
                                  List<String> names = [];

                                  for (int i = 0; i < filterHandler.availableFilters.length; i++) {
                                    names.add(filterHandler.availableFilters[i].name);
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
                                                for (int i = 0; i < filterHandler.availableFilters.length; i++) {
                                                  if (filterHandler.availableFilters[i].name == newValue) {
                                                    int localid = filter.localid;
                                                    filter = new Filter(
                                                        id: filterHandler.availableFilters[i].id,
                                                        name: filterHandler.availableFilters[i].name,
                                                        description: filterHandler.availableFilters[i].description);
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
                                          Text('Max distance: '),
                                          Expanded(
                                            child: TextField(
                                              controller: myController,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
                            filterHandler.updateFilters(filter);
                            setMainState();
                            Navigator.pop(context);
                          },
                        ),
                      ),
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
*/
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return new Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.2,
      margin: EdgeInsets.all(5.0),
      color: themeData.primaryColor,
      child: Column(
        children: [
          Container(
            // TitleBar
            //This may not be an appbar but because it uses the kToolbarHeight
            //variable it still has the same size
            height: Size.fromHeight(kToolbarHeight).height,
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Row(children: [
              Text("Filters",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              Spacer(),
              IconButton(
                icon: Icon(Icons.add),
                tooltip:
                    'New Filter', /*
                onPressed: () {
                  setState(() {
                    filter = null;
                  });
                  showFilterTemplateGUI();
                },*/
              ),
            ]),
          ),
          Container(
            //Content
            height: MediaQuery.of(context).size.height * 0.7,
            //child: ReturnContent(context, allfilters, filterHandler.activeFilters, filterHandler.inactiveFilters),
          ),
        ],
      ),
    );
  }
/*
  Widget ReturnContent(context, allfilters, activeFilters, inactiveFilters) {
    if ((activeFilters != null && activeFilters.length > 0) || (inactiveFilters != null && inactiveFilters.length > 0)) {
      return Scrollbar(
        child: ListView.builder(
          itemCount: allfilters.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
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
                                    filterHandler.activateFilter(allfilters[index]);
                                    setMainState();
                                  }
                                : null,
                            child: Text('Activate'),
                          ),
                          ElevatedButton(
                            onPressed: index < activeFilters.length
                                ? () {
                                    filterHandler.deactivateFilter(allfilters[index]);
                                    setMainState();
                                  }
                                : null,
                            child: Text('Deactivate'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              filterHandler.deleteFilter(allfilters[index]);
                              setMainState();
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
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
      );
    } else {
      return Center(child: Text("No Filters added"));
    }
  }*/
}
