import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../../../style/style.dart';

class Detail_User extends StatefulWidget {
  const Detail_User({super.key});

  @override
  State<Detail_User> createState() => _Detail_UserState();
}

class _Detail_UserState extends State<Detail_User> {
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
