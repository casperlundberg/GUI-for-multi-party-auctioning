import 'package:flutter/material.dart';
import '../navigationbar/navbar.dart';
import 'homescreen.dart';
import 'login.dart';
import 'register.dart';
import 'forgotPass.dart';
//Inspired by Widget Switch Demo, by GitHub user TechieBlossom
//https://github.com/TechieBlossom/flutter-samples/blob/master/widgetswitchdemo.dart

enum WidgetMarker { home, login, register, profile, forgotPass }

class MainGUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainGUIState();
}

class MainGUIState extends State<MainGUI>
    with SingleTickerProviderStateMixin<MainGUI> {
  WidgetMarker selectedWidgetMarker = WidgetMarker.login;
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
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
            appBar: NavigationBar(),
            backgroundColor: Colors.transparent,
            body: FutureBuilder(
                future: _playAnimation(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return getCustomContainer();
                })));
  }

  _playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  Widget getCustomContainer() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.home:
        return getHomeContainer();
      case WidgetMarker.login:
        return getLoginContainer();
      case WidgetMarker.profile:
        return getProfileContainer();
      case WidgetMarker.register:
        return getRegisterContainer();
      case WidgetMarker.forgotPass:
        return getForgotPassContainer();
    }
    return getLoginContainer();
  }

  Widget getHomeContainer() {
    return FadeTransition(
      opacity: _animation,
      child: AuctionContainers(),
    );
  }

  Widget getLoginContainer() {
    return FadeTransition(
      opacity: _animation,
      child: LoginScreen(this),
    );
  }

  Widget getRegisterContainer() {
    return FadeTransition(
      opacity: _animation,
      child: RegisterScreen(this),
    );
  }

  Widget getForgotPassContainer() {
    return FadeTransition(
      opacity: _animation,
      child: ForgotPasswordScreen(this),
    );
  }

  Widget getProfileContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        color: Colors.blue,
        height: 400,
      ),
    );
  }
}
