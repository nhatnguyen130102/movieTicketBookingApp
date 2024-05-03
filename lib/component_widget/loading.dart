import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../style/style.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(white.withOpacity(0.5)),
            strokeWidth: 3.0,
          ),
          Gap(16),
          Text(
            'Loading',
            style: TextStyle(color: white.withOpacity(0.5), fontWeight: medium,),
          ),
        ],
      ),
    );
  }
}
