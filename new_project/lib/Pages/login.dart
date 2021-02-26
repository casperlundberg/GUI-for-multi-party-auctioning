import 'package:flutter/material.dart';

import '../State/mainGUI.dart';
import '../Entities/user.dart';
import '../Entities/userList.dart';
import '../jsonUtilities.dart';
import 'userInfoHandler.dart';

class LoginScreen extends StatefulWidget {
  final Function navigate;
  final User user;
  final UserList userListObject;
  final UserInfoHandler userHandler;
  const LoginScreen(this.navigate, this.user, this.userListObject, this.userHandler);

  @override
  Login createState() => Login(navigate, user, userListObject, userHandler);
}

class Login extends State<LoginScreen> {
  final Function navigate;
  User user;
  final UserList userListObject;
  final UserInfoHandler userHandler;

  Login(this.navigate, this.user, this.userListObject, this.userHandler);

  final TextEditingController _controllerUserName = new TextEditingController();
  final TextEditingController _controllerPW = new TextEditingController();

  String loginUserName;
  String loginPW;

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Login', style: themeData.textTheme.headline4),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Username'),
                    controller: _controllerUserName,
                    onChanged: (String value) {
                      loginUserName = value;
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
                      loginPW = userHandler.passHasher(value);
                    },
                  ),
                ),
                TextButton(
                    child: Text('Signup'),
                    onPressed: () {
                      navigate(WidgetMarker.register);
                    }),
                TextButton(
                  child: Text('Login'),
                  onPressed: () {
                    if (userHandler.loginValidator(loginUserName, loginPW) != null) {
                      user = userHandler.loginValidator(loginUserName, loginPW);
                      setUserString(userToJson(user));
                      navigate(WidgetMarker.auctions);
                    }
                  },
                ),
                TextButton(
                  child: Text('Forgot password?'),
                  onPressed: () {
                    navigate(WidgetMarker.forgotPass);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
