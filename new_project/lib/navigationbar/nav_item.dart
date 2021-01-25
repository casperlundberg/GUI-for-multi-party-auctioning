import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  final String title;

  const NavigationItem({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
