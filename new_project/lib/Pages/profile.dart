import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../State/mainGUI.dart';
import '../Entities/localJSONUserPage.dart';
import '../jsonUtilities.dart';

class ProfileGUI extends StatefulWidget {
  final Function navigate;
  final LocalJsonUserPage user;

  const ProfileGUI(
    this.navigate,
    this.user,
  );
  @override
  Profile createState() => Profile(navigate, user);
}

class Profile extends State<ProfileGUI> {
  final Function navigate;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final TextEditingController _controllerUserName = new TextEditingController();
  final TextEditingController _controllerEmail = new TextEditingController();
  final TextEditingController _controllerAge = new TextEditingController();
  final TextEditingController _controllerAddress = new TextEditingController();
  final TextEditingController _controllerCity = new TextEditingController();
  final TextEditingController _controllerState = new TextEditingController();
  final TextEditingController _controllerPostalCode = new TextEditingController();
  final TextEditingController _controllerHomePhoneNumber = new TextEditingController();
  final TextEditingController _controllerMobilePhoneNumber = new TextEditingController();
  final TextEditingController _controllerOfficePhoneNumber = new TextEditingController();

  LocalJsonUserPage user;

  Profile(this.navigate, this.user);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    //final DateTime today = new DateTime.now();

    if (user != null) {
      return Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          width: MediaQuery.of(context).size.width * 0.30,
          color: Colors.transparent,
          child: Card(
            color: themeData.primaryColor,
            child: new Form(
              key: _formKey,
              //autovalidate: _autovalidate,
              //onWillPop: _warnUserAboutInvalidData,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 8.0),
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "Username",
                          hintText: "What do people call you?",
                        ),
                        autocorrect: false,
                        controller: _controllerUserName..text = user.userName,
                        onChanged: (String value) {
                          user.userName = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "E-mail",
                        ),
                        autocorrect: false,
                        controller: _controllerEmail..text = user.email,
                        onChanged: (String value) {
                          user.email = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "Age",
                        ),
                        autocorrect: false,
                        controller: _controllerAge..text = user.age.toString(),
                        onChanged: (String value) {
                          user.age = value as int;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "Address",
                        ),
                        autocorrect: false,
                        controller: _controllerAddress..text = user.address.streetAddress,
                        onChanged: (String value) {
                          user.address.streetAddress = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "City",
                        ),
                        autocorrect: false,
                        controller: _controllerCity..text = user.address.city,
                        onChanged: (String value) {
                          user.address.city = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "State",
                        ),
                        autocorrect: false,
                        controller: _controllerState..text = user.address.state,
                        onChanged: (String value) {
                          user.address.state = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "Postal code",
                        ),
                        autocorrect: false,
                        controller: _controllerPostalCode..text = user.address.postalCode,
                        onChanged: (String value) {
                          user.address.postalCode = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "Home phone number",
                        ),
                        autocorrect: false,
                        controller: _controllerHomePhoneNumber..text = user.homePhoneNumber,
                        onChanged: (String value) {
                          user.homePhoneNumber = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "Mobile phone number",
                        ),
                        autocorrect: false,
                        controller: _controllerMobilePhoneNumber..text = user.mobilePhoneNumber,
                        onChanged: (String value) {
                          user.mobilePhoneNumber = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "Home phone number",
                        ),
                        autocorrect: false,
                        controller: _controllerOfficePhoneNumber..text = user.officePhoneNumber,
                        onChanged: (String value) {
                          user.officePhoneNumber = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text('User Type:  '),
                                  new DropdownButton<String>(
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    value: user.currentType,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.white),
                                    items: <String>['Supplier', 'Demander'].map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        user.currentType = newValue;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text("Save changes"),
                        onPressed: () {
                          setUserString(localJsonUserPageToJson(user));
                          navigate(WidgetMarker.auctions);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return new Container();
    }
  }
}
