import 'package:flutter/material.dart';
import 'nav_special.dart';
import 'nav_item.dart';

class NavigationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          NavigationItem(title: 'Home'),
          NavigationItem(title: 'About'),
          NavigationItem(title: 'Contact'),
          SpecialNavigationItem(title: 'Login'),
          SpecialNavigationItem(title: 'Signup'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
