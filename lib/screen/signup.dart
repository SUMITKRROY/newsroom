import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsbook/screen/login.dart';

import '../utills/helper_widget.dart';
import '../widget/button.dart';
import '../widget/text_only.dart';
import '../widget/textform.dart';
import 'news_room.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }
  Future<void> _signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Handle the newly created user (e.g., save to Firestore)
      // You can add your own logic here.

      print('User signed up: ${userCredential.user?.email}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );

    } catch (e) {
      print('Error signing up: $e');
      Utils.toastMessage("email-already-in-use");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.black,
        title: TextOnly(label: "Create New Account", style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
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
            SizedBox(height: 32),
            CustomButton(
              onPressed: _signUp,
              title:  'Sign Up',
            ),

          ],
        ),
      ),
    );
  }
}


