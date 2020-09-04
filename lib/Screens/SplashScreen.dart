import 'package:flutter/material.dart';
import 'package:iostudy/Screens/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  static String navtag = "splashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigate() {
    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(context, HomeScreen.navtag);
    });
  }

  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, 0.2),
            child: Container(
              height: 200,
              child: Image.asset(
                "assets/images/splash.png",
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
