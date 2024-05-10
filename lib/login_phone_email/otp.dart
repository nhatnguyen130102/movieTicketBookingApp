import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:project_1/style/style.dart';

class Myotp extends StatefulWidget {
  final String verificationId;
  const Myotp({Key? key, required this.verificationId}) : super(key: key);


  @override
  State<Myotp> createState() => _MyotpState();
}

class _MyotpState extends State<Myotp> {
  TextEditingController otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;


  Future<void> signInWithOTP(BuildContext context) async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otpController.text.trim(),
    );
    await auth.signInWithCredential(credential);
    Navigator.pushNamed(context, 'mainlayout');
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Mã OTP sai'),
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
    final String verificationId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                'Enter your OTP code',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 10,
              ),


              TextFormField(
                controller: otpController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.monitor_heart_outlined,
                    color: white.withOpacity(0.8),
                    ),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    hintText: "OTP code",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                    ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter OTP';
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
                    signInWithOTP(context);
                  },
                  child: Text('Confirm', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),


              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
                      },
                      child: Text('Change your phone number ?', style: TextStyle(color: Colors.black)))
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}


class OTPInputBox extends StatefulWidget {
  @override
  _OTPInputBoxState createState() => _OTPInputBoxState();
}

class _OTPInputBoxState extends State<OTPInputBox> {
  late List<TextEditingController> controllers;
  late FocusNode lastFocusNode;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (index) => TextEditingController());
    lastFocusNode = FocusNode();
    lastFocusNode.addListener(() {
      if (!lastFocusNode.hasFocus) {
        FocusScope.of(context).previousFocus();
      }
    });
  }

  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());
    lastFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) => Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.withOpacity(0.2),
          ),
          child: TextField(
            controller: controllers[index],
            maxLength: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: TextStyle(fontWeight: FontWeight.bold), // Make text bold
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.zero,
            ),
            cursorColor: Colors.transparent, // Make cursor color transparent
            onChanged: (value) {
              if (value.isEmpty) {
                if (index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              } else {
                if (index < 5) {
                  FocusScope.of(context).nextFocus();
                } else {
                  lastFocusNode.requestFocus();
                }
              }
            },
          ),
        ),
      )..add(SizedBox(width: 0)), // to add extra space
    );
  }
}

