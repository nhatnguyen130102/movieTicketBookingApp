import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_1/style/style.dart';


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


                Text(
                  'Register',
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
