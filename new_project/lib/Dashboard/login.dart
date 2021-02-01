import 'dart:html';

import 'package:flutter/material.dart';
import 'mainGUI.dart';

class LoginScreen extends StatelessWidget {
  MainGUIState parent;
  LoginScreen(this.parent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: SizedBox(
                width: 500,
                child: Card(
                    child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Login',
                          style: Theme.of(context).textTheme.headline4),
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
                            this.parent.setState(() {
                              this.parent.selectedWidgetMarker =
                                  WidgetMarker.register;
                            });
                          }),
                      TextButton(
                          child: Text('Login'),
                          onPressed: () {
                            this.parent.setState(() {
                              this.parent.selectedWidgetMarker =
                                  WidgetMarker.home;
                            });
                          }),
                      TextButton(
                          child: Text('Forgot password?'),
                          onPressed: () {
                            this.parent.setState(() {
                              this.parent.selectedWidgetMarker =
                                  WidgetMarker.forgotPass;
                            });
                          }),
                    ],
                  ),
                )))));
  }
}
