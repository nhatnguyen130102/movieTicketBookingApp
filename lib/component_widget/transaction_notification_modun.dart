import 'package:flutter/material.dart';
import 'package:project_1/screen/billingpage.dart';
import 'package:project_1/screen/mainlayout.dart';
import 'package:project_1/style/style.dart';

class Transaction_Notification_Modun extends StatelessWidget {
  const Transaction_Notification_Modun({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MainLayout(); // cần sửa
          }),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 15),
        height: 170,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                '08:32 AM - 02/04/2024',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 131, 131, 131),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                'Notice of payment',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                'ACB: Acc 12341234',
                style: TextStyle(
                  fontSize: 15,
                  color: black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                'Transfer to: CINEON - B 1234-1234-Q',
                style: TextStyle(
                  fontSize: 15,
                  color: black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 15),
              alignment: Alignment.topLeft,
              child: Text(
                'Amount: 685.000 (VND) - ID: 123456',
                style: TextStyle(
                  fontSize: 15,
                  color: black.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
