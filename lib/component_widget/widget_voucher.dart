import 'package:flutter/material.dart';

class Widget_Voucher extends StatelessWidget {
  late String stringA;
  late String stringB;
  Widget_Voucher({
    required this.stringB,
    required this.stringA,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        '${stringA} (${stringB})',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}
