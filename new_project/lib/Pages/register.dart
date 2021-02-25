import 'dart:convert';
import 'package:crypt/crypt.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import '../Entities/localJSONUserPage.dart';
import '../Entities/userList.dart';
import '../jsonUtilities.dart';

import '../State/mainGUI.dart';

class RegisterScreen extends StatefulWidget {
  final Function navigate;
  final LocalJsonUserPage user;
  final UserList userListObject;
  const RegisterScreen(this.navigate, this.user, this.userListObject);

  @override
  Register createState() => Register(navigate, user, userListObject);
}

class Register extends State<RegisterScreen> {
  final Function navigate;
  final LocalJsonUserPage user;
  final UserList userListObject;

  final TextEditingController _controllerUserName = new TextEditingController();
  final TextEditingController _controllerEmail = new TextEditingController();
  final TextEditingController _controllerPW = new TextEditingController();
  final TextEditingController _controllerRPW = new TextEditingController();

  String newUserName;
  String newEmail;
  String pw;
  String rpw;

  Register(this.navigate, this.user, this.userListObject);

  // Check if a String is a valid email.
  // Return true if it is valid.
  bool isEmail(String email) {
    // Null or empty string is invalid
    if (email == null || email.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  bool userCheck(String userName, String email) {
    // Null or empty string is invalid
    if (userName == null || userName.isEmpty) {
      return false;
    }
    // check if email or username is taken, uses userList from json
    bool emailOK = false;
    bool userNameOK = false;
    for (int i = 0; i < userListObject.users.length; i++) {
      if (userListObject.users[i].email == email) {
        //email already taken pop-up

        print("Email is already taken");
        break;
      } else {
        emailOK = true;
      }

      if (userListObject.users[i].userName == userName) {
        //username already taken pop-up
        print("Username is already taken");
        break;
      } else {
        userNameOK = true;
      }
    }
    if (emailOK && userNameOK) {
      return true;
    }
    return false;
  }

  String passHasher(String password) {
    String salt = 'lVocjgjgXg8P7zIsC93kKleU8sPbTBhsAMFLnLUPDRYFIWAk';
    String saltedPassword = salt + password;
    var bytes = utf8.encode(saltedPassword);
    var hash = sha256.convert(bytes);
    return hash.toString();
  }

  bool passwordChecker(String hash, String hashRepeat) {
    // Null or empty string is invalid
    print("Password: " + hash);
    print("Repeated password: " + hashRepeat);

    if (hash == null || hash.isEmpty || hashRepeat == null || hashRepeat.isEmpty) {
      return false;
    }

    if (hash == hashRepeat) {
      return true;
    }
    return false;
  }

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
                        pw = passHasher(value);
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
                        rpw = passHasher(value);
                      },
                    ),
                  ),
                  TextButton(
                    child: Text('Signup'),
                    onPressed: () {
                      if (isEmail(newEmail)) {
                        // test to check if email & username is taken
                        if (userCheck(newUserName, newEmail)) {
                          if (passwordChecker(pw, rpw)) {
                            user.userId = userListObject.users.length + 1;
                            user.userName = newUserName;
                            user.email = newEmail;
                            user.password.encryption = pw;
                            user.password.type = "sha256";
                            userListObject.users.add(user);
                            print(userListToJson(userListObject));
                            navigate(WidgetMarker.auctions);
                          } else {
                            // Password missmatch pop-up
                            print("Password missmatch");
                          }
                        }
                      } else {
                        // Email format error pop-up
                        print("Email format error");
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
