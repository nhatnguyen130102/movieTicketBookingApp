import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyPhone extends StatefulWidget {
  const MyPhone({super.key});

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  String verificationId = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> verifyPhoneNumber(BuildContext context) async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  String phoneNumber = '+${countryCodeController.text.trim()}${phoneNumberController.text.trim()}';
  FirebaseAuth auth = FirebaseAuth.instance;

  await auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Xác minh số điện thoại thất bại'),
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
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushNamed(context, 'otp', arguments: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
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
