import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_1/newDire/success.dart';

import 'entry.dart'; 

class MyEmail extends StatefulWidget {
  const MyEmail({Key? key}) : super(key: key);

  @override
  _MyEmailState createState() => _MyEmailState();
}

class _MyEmailState extends State<MyEmail> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //Theo dõi trạng thái đăng nhập (Authentication) của người dùng
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && user.emailVerified) {
        print('User is authenticated and email is verified');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyWidget()),
        );
      }
    });
  }

  Future<void> sendVerificationEmail(BuildContext context) async {
    String email = emailController.text.trim();

    try {
      //Tạo User mới với mật khẩu tạm thời
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: 'dummyPassword', //Mật khẩu tạm thời
      );

      //Gửi link xác nhận
      User? user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();

      // Hiện thông báo người dùng kiểm tra Email
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Đã gửi link xác nhận'),
            content: Text('Vui lòng kiểm tra email để xác nhận'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  //Sau khi gửi link quay về màn hình entry.dart
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      //Khi gặp lỗi (e.g., invalid email, account already exists, etc.)
      print('Error creating account: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lỗi'),
            content: Text('Tạo tài khoản thất bại'),
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

              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'example@yahoo.com',
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Vui lòng nhập địa chỉ email hợp lệ';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  sendVerificationEmail(context);
                },
                child: Text('Gửi link', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
