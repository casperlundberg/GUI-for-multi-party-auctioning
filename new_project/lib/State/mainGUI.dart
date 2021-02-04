import 'package:flutter/material.dart';

import '../navigationbar/navbar.dart';
import '../Auctions/room.dart';
import '../Entities/localJSONFilter.dart';

import '../Pages/auctionsGUI.dart';
import '../Pages/forgotPass.dart';
import '../Pages/login.dart';
import '../Pages/profile.dart';
import '../Pages/register.dart';

//Inspired by Widget Switch Demo, by GitHub user TechieBlossom
//https://github.com/TechieBlossom/flutter-samples/blob/master/widgetswitchdemo.dart

enum WidgetMarker { auctions, login, register, profile, forgotPass, room }

class MainGUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainGUIState();
}

class MainGUIState extends State<MainGUI>
    with SingleTickerProviderStateMixin<MainGUI> {
  WidgetMarker _selectedWidgetMarker;
  AnimationController _controller;
  Animation _animation;
  List<LocalJSONFilter> _filters;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _filters = [];
    _selectedWidgetMarker = WidgetMarker.login;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          //Source: https://www.pexels.com/photo/iphone-notebook-pen-working-34088/
          image: AssetImage("../../images/dark/main-BG-dark.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: NavigationBar(_navigate),
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: _playAnimation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return _getCustomContainer();
          },
        ),
      ),
    );
  }

  _playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  void _updateFilters(List<LocalJSONFilter> selectedFilters) {
    setState(() {
      _filters = selectedFilters;
    });
  }

  void _navigate(WidgetMarker page) {
    switch (page) {
      case WidgetMarker.auctions:
        setState(() {
          _selectedWidgetMarker = WidgetMarker.auctions;
        });
        return;
      case WidgetMarker.login:
        setState(() {
          _selectedWidgetMarker = WidgetMarker.login;
        });
        return;
      case WidgetMarker.profile:
        setState(() {
          _selectedWidgetMarker = WidgetMarker.profile;
        });
        return;
      case WidgetMarker.register:
        setState(() {
          _selectedWidgetMarker = WidgetMarker.register;
        });
        return;
      case WidgetMarker.forgotPass:
        setState(() {
          _selectedWidgetMarker = WidgetMarker.forgotPass;
        });
        return;
      case WidgetMarker.room:
        setState(() {
          _selectedWidgetMarker = WidgetMarker.room;
        });
    }
  }

  Widget _getCustomContainer() {
    switch (_selectedWidgetMarker) {
      case WidgetMarker.auctions:
        return getAuctionsGUIContainer();
      case WidgetMarker.login:
        return getLoginContainer();
      case WidgetMarker.profile:
        return getProfileContainer();
      case WidgetMarker.register:
        return getRegisterContainer();
      case WidgetMarker.forgotPass:
        return getForgotPassContainer();
      case WidgetMarker.room:
        return getRoomContainer();
    }
    return getLoginContainer();
  }

  Widget getAuctionsGUIContainer() {
    return FadeTransition(
      opacity: _animation,
      child: AuctionsGUI(_navigate, _filters, _updateFilters),
    );
  }

  Widget getLoginContainer() {
    return FadeTransition(
      opacity: _animation,
      child: LoginScreen(_navigate),
    );
  }

  Widget getRegisterContainer() {
    return FadeTransition(
      opacity: _animation,
      child: RegisterScreen(_navigate),
    );
  }

  Widget getForgotPassContainer() {
    return FadeTransition(
      opacity: _animation,
      child: ForgotPasswordScreen(_navigate),
    );
  }

  Widget getProfileContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Profile(_navigate),
    );
  }

  Widget getRoomContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Room(_navigate),
    );
  }
}
