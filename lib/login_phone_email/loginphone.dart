import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_1/style/style.dart';

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
          Navigator.pushNamed(context, 'otp', arguments: verificationId);
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


                Text(
                  'Login',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),


                SizedBox(
                  height: 30,
                ),


                TextFormField(
                  controller: countryCodeController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                    Icons.code_outlined,
                    color: white.withOpacity(0.8),
                    ),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    hintText: "Country code",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                    ),
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
                    prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: white.withOpacity(0.8),
                    ),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    hintText: "Phone number",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                    ),
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
                    child: Text('Send OTP', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
