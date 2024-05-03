import 'package:flutter/material.dart';

class ChooseTime_Modun extends StatelessWidget {
  final StringA;
  const ChooseTime_Modun({
    this.StringA,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          StringA,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
