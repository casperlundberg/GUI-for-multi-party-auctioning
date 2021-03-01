import 'package:flutter/material.dart';

import '../Handlers/userInfoHandler.dart';
import '../mainGUI.dart';

class RegisterScreen extends StatefulWidget {
  final Function navigate;
  final UserInfoHandler userHandler;
  final Function userToAuction;
  const RegisterScreen(this.navigate, this.userHandler, this.userToAuction);

  @override
  Register createState() => Register(navigate, userHandler, userToAuction);
}

class Register extends State<RegisterScreen> {
  final Function navigate;
  final UserInfoHandler userHandler;
  final Function userToAuction;

  Register(this.navigate, this.userHandler, this.userToAuction);

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
                            userHandler.register(newUserName, newEmail, pw);
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
