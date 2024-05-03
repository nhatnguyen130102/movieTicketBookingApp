
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:project_1/newDire/phone.dart';
import 'dart:io' as io show Platform;

import 'package:project_1/newDire/success.dart';

import 'entry.dart';
import 'otp.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  io.Platform.isAndroid 
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyBxFvDCVasFJpLvr9hg6yoXyRsT7Ls3NSU', 
            appId: '1:792703127539:android:4ecd5f11cd68dd7867cc86', 
            messagingSenderId: '792703127539', 
            projectId: 'emailandphonelogin'
          )
        )

      : await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EntryScreen(),
      //đường tắt
      routes: {
        'success' : (context) => MyWidget(),
        'entry' : (context) => EntryScreen(),
        'phone': (context) => MyPhone(), 
        'otp': (context) => Myotp(verificationId: ModalRoute.of(context)!.settings.arguments as String),

      },
    );
  }
}