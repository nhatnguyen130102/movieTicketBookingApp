import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_1/login_phone_email/success.dart';
import 'package:project_1/style/style.dart';


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


              Text(
                'Login',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),


              SizedBox(height: 30),


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
                      verifyAccount(context);
                    },
                    child: Text('Verify', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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


              SizedBox(height: 10),


              SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      sendVerificationLink(context);
                    },
                    child: Text('Send link', style: TextStyle(color: Colors.black)),
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
