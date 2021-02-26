import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_project/Entities/userList.dart';
import '../State/mainGUI.dart';
import '../Entities/user.dart';
import '../jsonUtilities.dart';
import 'userInfoHandler.dart';

class ProfileGUI extends StatefulWidget {
  final Function navigate;
  final User user;
  final UserInfoHandler userHandler;
  final UserList userListObject;

  const ProfileGUI(
    this.navigate,
    this.user,
    this.userListObject,
    this.userHandler,
  );
  @override
  Profile createState() => Profile(navigate, user, userListObject, userHandler);
}

class Profile extends State<ProfileGUI> {
  final Function navigate;
  User user;
  UserList userListObject;
  UserInfoHandler userHandler;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Profile(this.navigate, this.user, this.userListObject, this.userHandler);

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
  final TextEditingController _controllerCompany = new TextEditingController();
  final TextEditingController _controllerOPW = new TextEditingController();
  final TextEditingController _controllerPW = new TextEditingController();
  final TextEditingController _controllerRPW = new TextEditingController();

  String newUserName;
  String newEmail;
  int newAge;
  String newAddress;
  String newCity;
  String newState;
  String newPostalCode;
  String newHomePhoneNumber;
  String newMobilePhoneNumber;
  String newOfficePhoneNumber;
  String newCurrentType;
  String newCompany;
  String opw;
  String pw;
  String rpw;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    //final DateTime today = new DateTime.now();
    if (user != null) {
      newUserName = user.userName;
      newEmail = user.email;
      newAge = user.age;
      newAddress = user.address.streetAddress;
      newCity = user.address.city;
      newState = user.address.state;
      newPostalCode = user.address.postalCode;
      newHomePhoneNumber = user.homePhoneNumber;
      newMobilePhoneNumber = user.mobilePhoneNumber;
      newOfficePhoneNumber = user.officePhoneNumber;
      newCurrentType = user.currentType;
      newCompany = user.company;
      userHandler = new UserInfoHandler(userListObject, user);

      print(user.userId);

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
                    Text('Edit Profile', style: themeData.textTheme.headline4),
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
                          newUserName = value;
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
                          newEmail = value;
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
                          newAge = value as int;
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
                          newAddress = value;
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
                          newCity = value;
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
                          newState = value;
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
                          newPostalCode = value;
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
                          newHomePhoneNumber = value;
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
                          newMobilePhoneNumber = value;
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
                          newOfficePhoneNumber = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "Company",
                        ),
                        autocorrect: false,
                        controller: _controllerCompany..text = user.company,
                        onChanged: (String value) {
                          newCompany = value;
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
                                    value: user.currentType == "Supplier" || user.currentType == "Demander" ? user.currentType : "Supplier",
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
                                        newCurrentType = newValue;
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
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Old password'),
                        controller: _controllerOPW,
                        onChanged: (String value) {
                          opw = userHandler.passHasher(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'New password'),
                        controller: _controllerPW,
                        onChanged: (String value) {
                          pw = userHandler.passHasher(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Repeat password'),
                        controller: _controllerRPW,
                        onChanged: (String value) {
                          rpw = userHandler.passHasher(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text("Save changes"),
                        onPressed: () {
                          if (userHandler.profileEditCheck(newUserName, newEmail, newMobilePhoneNumber)) {
                            if (userHandler.passwordChecker(pw, rpw)) {
                              if (userHandler.passwordValidator(opw)) {
                                user.userName = newUserName;
                                user.email = newEmail;
                                user.age = newAge;
                                user.address.streetAddress = newAddress;
                                user.address.city = newCity;
                                user.address.state = newState;
                                user.address.postalCode = newPostalCode;
                                user.homePhoneNumber = newHomePhoneNumber;
                                user.mobilePhoneNumber = newMobilePhoneNumber;
                                user.officePhoneNumber = newOfficePhoneNumber;
                                user.currentType = newCurrentType;
                                user.company = newCompany;
                                user.password.encryption = pw;
                                setUserString(userToJson(user));
                                navigate(WidgetMarker.auctions);
                              }
                            }
                          }
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
