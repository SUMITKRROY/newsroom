import 'package:flutter/material.dart';
import 'package:newsbook/widget/text_only.dart';
import 'login.dart';
import 'news_room.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // Simulate a delay, replace with actual logic to check the token
    await Future.delayed(Duration(seconds: 2));

    if (token != null) {
      // User is logged in, navigate to NewsRoom
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NewsRoom()),
      );
    } else {
      // User is not logged in, navigate to LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: TextOnly(label: "Welcome to NewsRoom", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
