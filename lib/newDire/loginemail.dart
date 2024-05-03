import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_1/newDire/success.dart';


class LoginEmail extends StatefulWidget {
  const LoginEmail({Key? key}) : super(key: key);

  @override
  _LoginEmailState createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  TextEditingController emailController = TextEditingController();
  bool isAccountVerified = false;
  String verificationMessage = '';

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && user.emailVerified) {
        //Chuyển sang màn hình success.dart khi xác minh Email thành công
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyWidget()),
        );
      }
    });
  }

  //Xác minh tài khoản
  void verifyAccount(BuildContext context) async {
    String email = emailController.text.trim();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: 'dummyPassword',
      );
      setState(() {
        isAccountVerified = true;
        verificationMessage = 'Xác minh thành công';
      });
    } catch (e) {
      setState(() {
        isAccountVerified = false;
        verificationMessage = 'Xác minh không thành công';
      });
    }
  }

  //Gửi link xác minh
  void sendVerificationLink(BuildContext context) async {
    String email = emailController.text.trim();

    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
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
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error sending verification link: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Image.asset(
                'assets/img1.png',
                width: 150,
                height: 150,
              ),


              SizedBox(height: 25),


              Text(
                'Đăng nhập bằng email',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),


              SizedBox(height: 10),


              Text(
                'Vui lòng nhập địa chỉ email của bạn',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),


              SizedBox(height: 30),


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
                  verifyAccount(context);
                },
                child: Text('Xác minh', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),


              SizedBox(height: 20),


              if (verificationMessage.isNotEmpty)
                Text(
                  verificationMessage,
                  style: TextStyle(
                    color: isAccountVerified ? Colors.green : Colors.red,
                  ),
                ),


              SizedBox(height: 20),


              ElevatedButton(
                onPressed: isAccountVerified
                    ? () {
                        sendVerificationLink(context);
                      }
                    : null,
                child: Text(
                  'Gửi link',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAccountVerified
                      ? Colors.green.shade600
                      : Colors.grey.shade400,
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
