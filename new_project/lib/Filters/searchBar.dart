import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:search_widget/search_widget.dart';

class SearchBarGUI extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _SearchBarGUIState createState() => new _SearchBarGUIState();
}

class _SearchBarGUIState extends State<SearchBarGUI> {
  List<SearchObject> list = <SearchObject>[
    SearchObject("Material", 1),
    SearchObject("Reference2", 2),
    SearchObject("Reference3", 3),
    SearchObject("Reference4", 4),
  ];

  SearchObject
      _selectedItem; // saves the selected item from search, can be accessed from auctions.dart. Maybe create a handler that search or shall we do it here?

  bool _show = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: <Widget>[
          if (_show)
            SearchWidget<SearchObject>(
              dataList: list,
              hideSearchBoxWhenItemSelected: false,
              listContainerHeight: MediaQuery.of(context).size.height / 6, // was 4 originally from open-source-packet
              queryBuilder: (query, list) {
                return list.where((item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
              },
              popupListItemBuilder: (item) {
                return PopupListItemWidget(item);
              },
              selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                return null; //SelectedItemWidget(selectedItem, deleteSelectedItem);
              },
              // widget customization
              //noItemsFoundWidget: NoItemsFound(),
              textFieldBuilder: (controller, focusNode) {
                return MyTextField(controller, focusNode);
              },
              onItemSelected: (item) {
                setState(() {
                  _selectedItem = item;
                });
              },
            ),
        ],
      ),
    );
  }
}

class SearchObject {
  SearchObject(this.name, this.id);

  final String name;
  final int id;
}

/* class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);

  final SearchObject selectedItem;
  final VoidCallback deleteSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                selectedItem.name,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, size: 22),
            //color: Colors.grey[700],
            onPressed: deleteSelectedItem,
          ),
        ],
      ),
    );
  }
} */

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(
          fontSize: 16,
          //color: Colors.grey[600],
        ),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                //color: Color(0x4437474F),
                ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search here...",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

/* class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          //color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            //color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
} */

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final SearchObject item;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Theme.of(context).accentColor,
      padding: const EdgeInsets.all(12),
      child: Text(
        item.name,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
