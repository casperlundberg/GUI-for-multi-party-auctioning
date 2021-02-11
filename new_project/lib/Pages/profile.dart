import 'package:flutter/material.dart';
import '../State/mainGUI.dart';
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
  //final TextEditingController _controllerUserType = new TextEditingController();
  LocalJsonUserPage user;

  Profile(this.navigate, this.user);

  @override
  Widget build(BuildContext context) {
    print(user.statusCode);
    final ThemeData themeData = Theme.of(context);
    //final DateTime today = new DateTime.now();

    if (user != null) {
      return Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.height * 0.4,
          color: themeData.primaryColor,
          child: new Form(
            key: _formKey,
            //autovalidate: _autovalidate,
            //onWillPop: _warnUserAboutInvalidData,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
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
                Padding(
                  padding: EdgeInsets.all(8.0),
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
                Padding(
                  padding: EdgeInsets.all(8.0),
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Save changes"),
                    onPressed: () {
                      navigate(WidgetMarker.auctions);
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
