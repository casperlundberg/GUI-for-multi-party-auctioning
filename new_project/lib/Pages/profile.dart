import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Entities/localJSONUserPage.dart';

class ProfileGUI extends StatefulWidget {
  final Function navigate;

  const ProfileGUI(this.navigate);
  @override
  Profile createState() => Profile(navigate);
}

class Profile extends State<ProfileGUI> {
  final Function navigate;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  //final TextEditingController _controllerUserName = new TextEditingController();
  final TextEditingController _controllerEmail = new TextEditingController();
  final TextEditingController _controllerAge = new TextEditingController();
  //final TextEditingController _controllerUserType = new TextEditingController();
  LocalJsonUserPage user;

  Profile(
    this.navigate,
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
/*     _controllerUserName.text = "Username test 1";
    _controllerEmail.text = "First name test 1";
    _controllerLastName.text = "Last name test 1"; */
    //final DateTime today = new DateTime.now();

    if (user != null) {
      return new Scaffold(
        appBar: new AppBar(
          title: const Text('Edit Profile'),
          actions: <Widget>[
            new Container(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
              child: new MaterialButton(
                color: themeData.primaryColor,
                textColor: themeData.secondaryHeaderColor,
                child: new Text('Save'),
                onPressed: () {
                  //_handleSubmitted();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        body: new Form(
          key: _formKey,
          //autovalidate: _autovalidate,
          //onWillPop: _warnUserAboutInvalidData,
          child: Row(
            children: <Widget>[
              Container(
                child: new TextField(
                  decoration: const InputDecoration(
                    labelText: "Username",
                    hintText: "What do people call you?",
                  ),
                  autocorrect: false,
                  controller: new TextEditingController(
                    text: user.userInfo.userName,
                  ),
                  onChanged: (String value) {
                    //userName = value;
                  },
                ),
              ),
              Container(
                child: new TextField(
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                  ),
                  autocorrect: false,
                  controller: _controllerEmail..text = user.userInfo.email,
                  onChanged: (String value) {
                    //mail = value;
                  },
                ),
              ),
              Container(
                child: new TextField(
                  decoration: const InputDecoration(
                    labelText: "Age",
                  ),
                  autocorrect: false,
                  controller: _controllerAge..text = user.userInfo.age.toString(),
                  onChanged: (String value) {
                    //Age = value;
                  },
                ),
              ),
              Container(
                /* child: new TextField(
                decoration: const InputDecoration(
                  labelText: "Current user type",
                ),
                autocorrect: false,
                controller: _controllerUserType..text = user.userInfo.currentType,
                onChanged: (String value) {
                  //lastName = value;
                },
              ), */
                child: StatefulBuilder(
                  builder: (context, setState) {
                    String dropdownValue = user.userInfo.currentType;
                    List<String> types = ["Consumer", "Provider"];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text('User Type: '),
                            DropdownButton(
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              value: dropdownValue,
                              elevation: 16,
                              style: TextStyle(color: Colors.white),
                              items: types.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text("Save changes"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return new Container();
    }
  }
}
