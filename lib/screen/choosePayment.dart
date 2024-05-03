import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'dart:io';
import '../style/style.dart';
import 'payment_config.dart';
import 'package:pay/pay.dart';

class PaymentPage extends StatefulWidget{
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();

}
class _PaymentPageState extends State<PaymentPage>{
  String os = Platform.operatingSystem;

  var applePayButton = ApplePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
    paymentItems: const [
      PaymentItem(
        label: 'Item A',
        amount: '0.15',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Item B',
        amount: '0.15',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Total',
        amount: '0.3',
        status: PaymentItemStatus.final_price,
      ),
    ],
    style: ApplePayButtonStyle.black,
    width: double.infinity,
    height: 50,
    type: ApplePayButtonType.buy,
    margin: const EdgeInsets.only(top: 15),
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(child: CircularProgressIndicator()),
  );

  var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems: const [
      PaymentItem(
        label: 'Total',
        amount: '0.15',
        status: PaymentItemStatus.final_price,
      ),
    ],
    width: double.infinity,
    type: GooglePayButtonType.pay,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(child: CircularProgressIndicator()),
  );

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: white,
        leading: IconButton(
          icon: HeroIcon(
            HeroIcons.chevronLeft,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(child: Platform.isIOS ? applePayButton : googlePayButton),
      ),
    );
  }

}