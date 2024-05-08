import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../../../style/style.dart';

class Create_User extends StatefulWidget {
  const Create_User({super.key});

  @override
  State<Create_User> createState() => _Create_UserState();
}

class _Create_UserState extends State<Create_User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: white,
        leading: IconButton(
          icon: HeroIcon(
            HeroIcons.chevronLeft,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // title: Text('Name movie ${widget.number}'),
      ),

    );
  }
}
