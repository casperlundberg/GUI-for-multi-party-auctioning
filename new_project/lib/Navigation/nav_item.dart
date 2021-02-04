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

/* class SpecialNavigationItem extends StatelessWidget {
  final String title;

  const SpecialNavigationItem({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: IconButton(
        icon: Icons.account_circle,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
} */
