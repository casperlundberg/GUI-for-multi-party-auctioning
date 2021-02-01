import 'dart:html';

import 'package:flutter/material.dart';
import 'mainGUI.dart';

class ForgotPasswordScreen extends StatelessWidget {
  MainGUIState parent;
  ForgotPasswordScreen(this.parent);

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
                  Text('Forgot Password',
                      style: Theme.of(context).textTheme.headline4),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Email'),
                    ),
                  ),
                  TextButton(
                    child: Text('Reset Password'),
                    onPressed: () {
                      this.parent.setState(
                        () {
                          //Should go to a waiting for confiramtion screen or just sit here with a message saying the same.
                          //this.parent.selectedWidgetMarker = WidgetMarker.register;
                        },
                      );
                    },
                  ),
                  TextButton(
                    child: Text('Back to login page'),
                    onPressed: () {
                      this.parent.setState(
                        () {
                          this.parent.selectedWidgetMarker = WidgetMarker.login;
                        },
                      );
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
