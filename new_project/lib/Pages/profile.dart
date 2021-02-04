import 'package:flutter/material.dart';
import '../Entities/localJSONUserPage.dart';

class ProfileGUI extends StatefulWidget {
  final Function navigate;

  const ProfileGUI(this.navigate);
  @override
  Profile createState() => Profile(navigate);
}

class Profile extends State<ProfileGUI> {
  final Function navigate;
  Profile(this.navigate);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final TextEditingController _controllerUserName = new TextEditingController();
  final TextEditingController _controllerEmail = new TextEditingController();
  final TextEditingController _controllerAge = new TextEditingController();
  final TextEditingController _controllerUserType = new TextEditingController();
  Future<LocalJSONUserPage> user;

  void initState() {
    super.initState();
    user = localJSONUserResponse;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
/*     _controllerUserName.text = "Username test 1";
    _controllerEmail.text = "First name test 1";
    _controllerLastName.text = "Last name test 1"; */
    //final DateTime today = new DateTime.now();

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
        child: StatefulBuilder(builder: (context, snapshot) {
          return FutureBuilder<LocalJSONUserPage>(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else {
                LocalJSONUserPage value = snapshot.data;
                return new ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    new Container(
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "Username",
                          hintText: "What do people call you?",
                        ),
                        autocorrect: false,
                        controller: _controllerUserName..text = value.userInfo.userName,
                        onChanged: (String value) {
                          //userName = value;
                        },
                      ),
                    ),
                    new Container(
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "E-mail",
                        ),
                        autocorrect: false,
                        controller: _controllerEmail..text = value.userInfo.email,
                        onChanged: (String value) {
                          //lastName = value;
                        },
                      ),
                    ),
                    new Container(
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "Age",
                        ),
                        autocorrect: false,
                        controller: _controllerAge..text = value.userInfo.age.toString(),
                        onChanged: (String value) {
                          //lastName = value;
                        },
                      ),
                    ),
                    new Container(
                      child: new TextField(
                        decoration: const InputDecoration(
                          labelText: "Current user type",
                        ),
                        autocorrect: false,
                        controller: _controllerUserType..text = value.userInfo.currentType,
                        onChanged: (String value) {
                          //lastName = value;
                        },
                      ),
                    ),
                    new Container(
                      child: ElevatedButton(
                        child: Text("Save changes"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          );
        }),
      ),
    );
  }
}
