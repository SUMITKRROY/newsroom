import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsbook/screen/signup.dart';
import 'package:newsbook/utills/helper_widget.dart';
import 'package:newsbook/widget/textform.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/button.dart';
import '../widget/hyperlink.dart';
import '../widget/text_only.dart';
import 'news_room.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }


  Future<void> _login() async {
    try {
      bool isValid = _formKey.currentState!.validate();
      if (isValid) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Handle the logged-in user (e.g., navigate to home screen)
        // You can add your own logic here.
        String email = "${userCredential.user?.email}";

        print('User logged in: $email');



        // Store Firebase Authentication ID token in shared preferences
        String? idToken = await userCredential.user!.getIdToken();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', idToken!);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NewsRoom()),
        );

      }

    } on FirebaseAuthException catch (e) {
      print('Authentication failed: ${e.code}');
      Utils.toastMessage("create new account");

        // User not found, navigate to SignUpPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()),
        );

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,

        title: TextOnly(label: "Log In", style: TextStyle(color: Colors.white),),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CustomTextField(
                label: 'Email',
                onChanged: (val) => {},
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == '') return 'Enter a valid email';
                  final emailRegExp =
                  RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
                  final isEmailValid = emailRegExp.hasMatch(val!);
                  if (!isEmailValid) return 'Enter a valid email';
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                controller: _passwordController,
                  keyboardType: TextInputType.text,
                onChanged: (val) => {},
                validator: (val) {
                  if (val == '') return 'Enter a valid password';
                  return null;
                },
                suffixIcon: IconButton(
                  color: Colors.grey,
                  icon: Icon(passwordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(
                          () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
                obscured: passwordVisible,
              ),
              SizedBox(height: 16),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [     Hyperlink(
      title: "forget password", onPressed: () {}), Hyperlink(
      title: "Create Account", onPressed: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }),],
),
              SizedBox(height: 32),
              CustomButton(
                onPressed: _login,
                title:  'Login',
              ),

            ],
          ),
        ),
      ),
    );
  }
}
