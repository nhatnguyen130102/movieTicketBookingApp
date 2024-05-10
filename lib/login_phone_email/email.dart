import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:project_1/style/style.dart';

import 'entry.dart'; 

class MyEmail extends StatefulWidget {
  const MyEmail({Key? key}) : super(key: key);

  @override
  _MyEmailState createState() => _MyEmailState();
}

class _MyEmailState extends State<MyEmail> {
  TextEditingController emailController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   //Theo dõi trạng thái đăng nhập (Authentication) của người dùng
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user != null && user.emailVerified) {
  //       print('User is authenticated and email is verified');
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => MyWidget()),
  //       );
  //     }
  //   });
  // }

  // Future<void> sendVerificationEmail(BuildContext context) async {
  //   String email = emailController.text.trim();

  //   try {
  //     //Tạo User mới với mật khẩu tạm thời
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: 'dummyPassword', //Mật khẩu tạm thời
  //     );

  //     //Gửi link xác nhận
  //     User? user = FirebaseAuth.instance.currentUser;
  //     await user!.sendEmailVerification();

  //     // Hiện thông báo người dùng kiểm tra Email
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Đã gửi link xác nhận'),
  //           content: Text('Vui lòng kiểm tra email để xác nhận'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 //Sau khi gửi link quay về màn hình entry.dart
  //                 Navigator.of(context).popUntil(ModalRoute.withName('/'));
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     //Khi gặp lỗi (e.g., invalid email, account already exists, etc.)
  //     print('Error creating account: $e');
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Account already exist'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  Future<void> sendOTPCode(BuildContext context) async {
    String email = emailController.text.trim();

    try {
      // ignore: deprecated_member_use
      var checkUser = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (checkUser.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Account already exists'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      // Send OTP code
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // Show success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Code Sent'),
            content: Text('An OTP code has been sent to your email address.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle errors
      print('Error sending OTP code: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send OTP code. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Text(
                  'Register',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),


                SizedBox(
                  height: 30,
                ),

              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail,
                    color: white.withOpacity(0.8),
                    ),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                    ),
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      sendOTPCode(context);
                      
                    },
                    child: Text('Send code', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}
