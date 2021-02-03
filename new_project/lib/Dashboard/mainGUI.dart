import 'package:flutter/material.dart';
import '../navigationbar/navbar.dart';
import 'AuctionsGUI.dart';
import 'login.dart';
import 'register.dart';
import 'forgotPass.dart';
import '../profile.dart';
import '../auctions/room.dart';
import '../entities/LocalJSONFilter.dart';

//Inspired by Widget Switch Demo, by GitHub user TechieBlossom
//https://github.com/TechieBlossom/flutter-samples/blob/master/widgetswitchdemo.dart

enum WidgetMarker { auctions, login, register, profile, forgotPass, room }

class MainGUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainGUIState();
}

class MainGUIState extends State<MainGUI>
    with SingleTickerProviderStateMixin<MainGUI> {
  WidgetMarker selectedWidgetMarker;
  AnimationController _controller;
  Animation _animation;
  List<LocalJSONFilter> filters;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    filters = [];
    selectedWidgetMarker = WidgetMarker.login;
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
        appBar: NavigationBar(navigate),
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: _playAnimation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return getCustomContainer();
          },
        ),
      ),
    );
  }

  _playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  void updateFilters(List<LocalJSONFilter> selectedFilters) {
    setState(() {
      filters = selectedFilters;
    });
  }

  void navigate(WidgetMarker page) {
    for (int i = 0; i < filters.length; i++) {
      print(filters[i].id);
    }
    switch (page) {
      case WidgetMarker.auctions:
        setState(() {
          selectedWidgetMarker = WidgetMarker.auctions;
        });
        return;
      case WidgetMarker.login:
        setState(() {
          selectedWidgetMarker = WidgetMarker.login;
        });
        return;
      case WidgetMarker.profile:
        setState(() {
          selectedWidgetMarker = WidgetMarker.profile;
        });
        return;
      case WidgetMarker.register:
        setState(() {
          selectedWidgetMarker = WidgetMarker.register;
        });
        return;
      case WidgetMarker.forgotPass:
        setState(() {
          selectedWidgetMarker = WidgetMarker.forgotPass;
        });
        return;
      case WidgetMarker.room:
        setState(() {
          selectedWidgetMarker = WidgetMarker.room;
        });
    }
  }

  Widget getCustomContainer() {
    switch (selectedWidgetMarker) {
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
      child: AuctionsGUI(navigate, filters, updateFilters),
    );
  }

  Widget getLoginContainer() {
    return FadeTransition(
      opacity: _animation,
      child: LoginScreen(navigate),
    );
  }

  Widget getRegisterContainer() {
    return FadeTransition(
      opacity: _animation,
      child: RegisterScreen(navigate),
    );
  }

  Widget getForgotPassContainer() {
    return FadeTransition(
      opacity: _animation,
      child: ForgotPasswordScreen(navigate),
    );
  }

  Widget getProfileContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Profile(navigate),
    );
  }

  Widget getRoomContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Room(navigate),
    );
  }
}
