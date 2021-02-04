import 'package:flutter/material.dart';

import '../State/mainGUI.dart';

class LoginScreen extends StatelessWidget {
  final Function navigate;
  LoginScreen(this.navigate);

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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
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
                      navigate(WidgetMarker.auctions);
                    }),
                TextButton(
                    child: Text('Forgot password?'),
                    onPressed: () {
                      navigate(WidgetMarker.forgotPass);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
