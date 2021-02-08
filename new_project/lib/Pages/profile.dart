import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Entities/localJSONUserPage.dart';

class ProfileGUI extends StatefulWidget {
  final Function navigate;
  final LocalJsonUserPage user;

  const ProfileGUI(this.navigate, this.user);
  @override
  Profile createState() => Profile(navigate, user);
}

class Profile extends State<ProfileGUI> {
  final Function navigate;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final TextEditingController _controllerUserName = new TextEditingController();
  final TextEditingController _controllerEmail = new TextEditingController();
  final TextEditingController _controllerAge = new TextEditingController();
  final TextEditingController _controllerUserType = new TextEditingController();
  LocalJsonUserPage user;

  Profile(this.navigate, this.user);

  @override
  Widget build(BuildContext context) {
    print(user.statusCode);
/*     return Container(
      width: 100,
      height: 100,
    ); */
    final ThemeData themeData = Theme.of(context);
    //final DateTime today = new DateTime.now();

    if (user != null) {
      return Center(
        child: Container(
          width: 600,
          height: 600,
          child: new Form(
            key: _formKey,
            //autovalidate: _autovalidate,
            //onWillPop: _warnUserAboutInvalidData,
            child: Column(
              children: <Widget>[
                Container(
                  child: new TextField(
                    decoration: const InputDecoration(
                      labelText: "Username",
                      hintText: "What do people call you?",
                    ),
                    autocorrect: false,
                    controller: _controllerUserName..text = user.userInfo.userName,
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
                /* Container(
                  child: new TextField(
                    decoration: const InputDecoration(
                      labelText: "Current user type",
                    ),
                    autocorrect: false,
                    controller: _controllerUserType..text = user.userInfo.currentType,
                    onChanged: (String value) {
                      //lastName = value;
                    },
                  ),
                ), */
                Container(
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text('User Type: '),
                              /* DropdownButton(
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
                              ), */
                              new DropdownButton<String>(
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 24,
                                value: user.userInfo.currentType,
                                elevation: 16,
                                style: TextStyle(color: Colors.white),
                                items: <String>['Supplier', 'Consumer'].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              )
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
        ),
      );
    } else {
      return new Container();
    }
  }
}
