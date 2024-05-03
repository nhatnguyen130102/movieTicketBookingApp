import 'package:flutter/material.dart';
import 'package:project_1/style/style.dart';

class ChooseDate_Modun extends StatelessWidget {
  final StringA;
  final StringB;
  const ChooseDate_Modun({
    required this.StringA,
    required this.StringB,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 4, right: 4),
            padding: EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Text(
              StringA,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              StringB,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
