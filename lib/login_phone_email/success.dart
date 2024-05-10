import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key});

  void signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Text(
              'Successfully logged in',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),


            SizedBox(height: 30),


            ElevatedButton(
              onPressed: () {
                signOut(context); //gọi phương thức đăng xuất
              },

              
              child: Text(
                'Đăng xuất',
                style: TextStyle(color: Colors.white),
              ),

              
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Use red color for sign out button
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
