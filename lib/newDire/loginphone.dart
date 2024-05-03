import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  String verificationId = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> verifyPhoneNumber(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String phoneNumber = '+${countryCodeController.text.trim()}${phoneNumberController.text.trim()}';

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            // Invalid phone number format
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Số điện thoại không hợp lệ'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (e.code == 'quota-reached') {
            // Too many requests in a short time (unlikely for your case)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Đã vượt quá số lần gửi mã OTP'),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            // Other verification failures
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Số điện thoại chưa được đăng kí'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          Navigator.pushNamed(context, 'otp', arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      // Handle other FirebaseAuthException errors (optional)
      print('Error verifying phone number: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Image.asset(
                  'assets/img1.png',
                  width: 150,
                  height: 150,
                ),


                SizedBox(
                  height: 25,
                ),


                Text(
                  'Mã đăng nhập điện thoại',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),


                SizedBox(
                  height: 10,
                ),


                Text(
                  'Chúng tôi cần đăng kí số điện thoại của bạn trước khi bắt đầu',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),


                SizedBox(
                  height: 30,
                ),


                TextFormField(
                  controller: countryCodeController,
                  decoration: InputDecoration(
                    hintText: "Country Code",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter country code';
                    }
                    return null;
                  },
                ),


                SizedBox(
                  height: 10,
                ),


                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    hintText: "Số điện thoại",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                ),


                SizedBox(
                  height: 20,
                ),


                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      verifyPhoneNumber(context);
                    },
                    child: Text('Gửi mã', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
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
      ),
    );
  }
}
