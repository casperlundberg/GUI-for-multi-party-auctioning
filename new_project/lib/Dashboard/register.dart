import 'package:flutter/material.dart';
import 'mainGUI.dart';

class RegisterScreen extends StatelessWidget {
  MainGUIState parent;
  RegisterScreen(this.parent);

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
                      Text('Signup',
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
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(hintText: 'Age'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(hintText: 'Address'),
                        ),
                      ),
                      TextButton(
                        child: Text('Signup'),
                        onPressed: () {},
                      ),
                      TextButton(
                          child: Text('Login'),
                          onPressed: () {
                            this.parent.setState(() {
                              this.parent.selectedWidgetMarker =
                                  WidgetMarker.login;
                            });
                          }),
                    ],
                  ),
                )))));
  }
}
