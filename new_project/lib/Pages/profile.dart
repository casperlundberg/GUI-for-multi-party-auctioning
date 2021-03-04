import 'dart:html';
import 'package:flutter/material.dart';

import '../mainGUI.dart';
import '../Handlers/userInfoHandler.dart';

class ProfileGUI extends StatefulWidget {
  final Function navigate;
  final UserInfoHandler userHandler;

  const ProfileGUI(this.navigate, this.userHandler);
  @override
  Profile createState() => Profile(navigate, userHandler);
}

class Profile extends State<ProfileGUI> {
  final Function navigate;
  final UserInfoHandler userHandler;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Profile(this.navigate, this.userHandler);

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
    newUserName = userHandler.user.userName;
    newEmail = userHandler.user.email;
    newAge = userHandler.user.age;
    newAddress = userHandler.user.address.streetAddress;
    newCity = userHandler.user.address.city;
    newState = userHandler.user.address.state;
    newPostalCode = userHandler.user.address.postalCode;
    newHomePhoneNumber = userHandler.user.homePhoneNumber;
    newMobilePhoneNumber = userHandler.user.mobilePhoneNumber;
    newOfficePhoneNumber = userHandler.user.officePhoneNumber;
    newCurrentType = userHandler.user.currentType;
    newCompany = userHandler.user.company;

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
                      controller: _controllerUserName..text = userHandler.user.userName,
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
                      controller: _controllerEmail..text = userHandler.user.email,
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
                      controller: _controllerAge..text = userHandler.user.age.toString(),
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
                      controller: _controllerAddress..text = userHandler.user.address.streetAddress,
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
                      controller: _controllerCity..text = userHandler.user.address.city,
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
                      controller: _controllerState..text = userHandler.user.address.state,
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
                      controller: _controllerPostalCode..text = userHandler.user.address.postalCode,
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
                      controller: _controllerHomePhoneNumber..text = userHandler.user.homePhoneNumber,
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
                      controller: _controllerMobilePhoneNumber..text = userHandler.user.mobilePhoneNumber,
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
                      controller: _controllerOfficePhoneNumber..text = userHandler.user.officePhoneNumber,
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
                      controller: _controllerCompany..text = userHandler.user.company,
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
                                  value: newCurrentType,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.white),
                                  items: <String>['Supplier', 'Consumer'].map((String value) {
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
                      decoration: InputDecoration(hintText: 'New password'),
                      controller: _controllerOPW,
                      onChanged: (String value) {
                        pw = userHandler.passHasher(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password'),
                      controller: _controllerPW,
                      onChanged: (String value) {
                        opw = userHandler.passHasher(value);
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
                          if (userHandler.loginValidator(userHandler.user.userName, opw) != null) {
                            if (pw != null) {
                              if (userHandler.passwordChecker(opw, rpw)) {
                                userHandler.user.userName = newUserName;
                                userHandler.user.email = newEmail;
                                userHandler.user.age = newAge;
                                userHandler.user.address.streetAddress = newAddress;
                                userHandler.user.address.city = newCity;
                                userHandler.user.address.state = newState;
                                userHandler.user.address.postalCode = newPostalCode;
                                userHandler.user.homePhoneNumber = newHomePhoneNumber;
                                userHandler.user.mobilePhoneNumber = newMobilePhoneNumber;
                                userHandler.user.officePhoneNumber = newOfficePhoneNumber;
                                userHandler.user.currentType = newCurrentType;
                                userHandler.user.company = newCompany;
                                userHandler.user.password.encryption = pw;
                                userHandler.updateProfile();
                                navigate(WidgetMarker.auctions);
                              }
                            } else {
                              if (userHandler.passwordChecker(opw, rpw)) {
                                userHandler.user.userName = newUserName;
                                userHandler.user.email = newEmail;
                                userHandler.user.age = newAge;
                                userHandler.user.address.streetAddress = newAddress;
                                userHandler.user.address.city = newCity;
                                userHandler.user.address.state = newState;
                                userHandler.user.address.postalCode = newPostalCode;
                                userHandler.user.homePhoneNumber = newHomePhoneNumber;
                                userHandler.user.mobilePhoneNumber = newMobilePhoneNumber;
                                userHandler.user.officePhoneNumber = newOfficePhoneNumber;
                                userHandler.user.currentType = newCurrentType;
                                userHandler.user.company = newCompany;
                                userHandler.updateProfile();
                                navigate(WidgetMarker.auctions);
                              }
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
  }
}
