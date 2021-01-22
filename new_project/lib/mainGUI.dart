import 'package:flutter/material.dart';

class MainGUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 500,
          child: Card(),
        ),
      ),
    );
  }
}
