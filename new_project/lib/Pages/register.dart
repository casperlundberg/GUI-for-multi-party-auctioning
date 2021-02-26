import 'dart:convert';
import 'package:crypt/crypt.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import '../Entities/user.dart';
import '../Entities/userList.dart';
import '../jsonUtilities.dart';
import 'userInfoHandler.dart';
import '../State/mainGUI.dart';

class RegisterScreen extends StatefulWidget {
  final Function navigate;
  final User user;
  final UserList userListObject;
  final UserInfoHandler userHandler;
  const RegisterScreen(this.navigate, this.user, this.userListObject, this.userHandler);

  @override
  Register createState() => Register(navigate, user, userListObject, userHandler);
}

class Register extends State<RegisterScreen> {
  final Function navigate;
  User user;
  UserList userListObject;
  final UserInfoHandler userHandler;

  Register(this.navigate, this.user, this.userListObject, this.userHandler);

  final TextEditingController _controllerUserName = new TextEditingController();
  final TextEditingController _controllerEmail = new TextEditingController();
  final TextEditingController _controllerPW = new TextEditingController();
  final TextEditingController _controllerRPW = new TextEditingController();

  String newUserName;
  String newEmail;
  String pw;
  String rpw;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: 500,
          child: Card(
            color: themeData.primaryColor,
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Signup', style: themeData.textTheme.headline4),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Username'),
                      controller: _controllerUserName,
                      onChanged: (String value) {
                        newUserName = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'E-mail'),
                      controller: _controllerEmail,
                      onChanged: (String value) {
                        newEmail = value;
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
                  TextButton(
                    child: Text('Signup'),
                    onPressed: () {
                      if (userHandler.isEmail(newEmail)) {
                        // test to check if email & username is taken
                        if (userHandler.userCheck(newUserName, newEmail)) {
                          if (userHandler.passwordChecker(pw, rpw)) {
                            user.userId = userListObject.users.length + 1;
                            user.userName = newUserName;
                            user.email = newEmail;
                            user.password.encryption = pw;
                            user.password.type = "sha256";
                            userListObject.users.add(user);
                            setUserString(userToJson(user));
                            setUserListString(userListToJson(userListObject));
                            navigate(WidgetMarker.auctions);
                          }
                        }
                      }
                    },
                  ),
                  TextButton(
                    child: Text('Back to login'),
                    onPressed: () {
                      navigate(WidgetMarker.login);
                    },
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
