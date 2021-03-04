import 'package:flutter/material.dart';

import '../mainGUI.dart';
import '../Handlers/userInfoHandler.dart';

class LoginScreen extends StatefulWidget {
  final Function navigate;
  final UserInfoHandler userHandler;
  const LoginScreen(this.navigate, this.userHandler);

  @override
  Login createState() => Login(navigate, userHandler);
}

class Login extends State<LoginScreen> {
  final Function navigate;
  final UserInfoHandler userHandler;

  Login(this.navigate, this.userHandler);

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
                      userHandler.login(userHandler.loginValidator(loginUserName, loginPW));
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
