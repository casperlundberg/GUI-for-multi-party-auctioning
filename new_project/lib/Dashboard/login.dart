/* import 'dart:html';

import 'package:flutter/material.dart';
import 'register.dart';
import 'mainGUI.dart';

class LoginScreen extends StatelessWidget {
  MainGUIState parent;
  LoginScreen(this.parent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 500,
          child: Card(
            child: LoginForm(this),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginScreen parent;
  LoginForm(this.parent);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Login', style: Theme.of(context).textTheme.headline4),
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
                this.parent.parent.setState(() {
                  this.parent.parent.selectedWidgetMarker = WidgetMarker.login;
                });
              }),
          TextButton(
              child: Text('Login'),
              onPressed: () {
                this.parent.parent.setState(() {
                  this.parent.parent.selectedWidgetMarker = WidgetMarker.login;
                });
              }),
        ],
      ),
    );
  }
} */
