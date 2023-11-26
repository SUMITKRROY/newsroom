import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsbook/provider/newsapi/news_bloc.dart';
import 'package:newsbook/screen/login.dart';
import 'package:newsbook/screen/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Replace the placeholder values with your actual Firebase configuration values
  FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyC5D2zcjNQ6L4y-I3YGmp-WIY32fi2z-Fc",
    appId: "1:241213592012:android:0db958f61fdd540e790d69",
    messagingSenderId: "241213592012",
    projectId: "flutter-project-947c5",
  );

  await Firebase.initializeApp(options: firebaseOptions);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => NewsBloc(),
          child: SplashScreen(),
        )
    );
  }
}

