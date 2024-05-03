import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:heroicons/heroicons.dart';
import 'package:project_1/screen/mainlayout.dart';

import 'api/firebase_api.dart';
import 'firebase_options.dart';
import 'style/style.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FireBaseApi().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // themeMode: ThemeMode.dark,
      // darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: background,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: white, displayColor: white),
        useMaterial3: true,
        // textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
        //   bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
        // ),
      ),
      home: MainLayout(),
    );
  }
}
