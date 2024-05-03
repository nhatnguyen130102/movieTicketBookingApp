import 'package:flutter/material.dart';

import 'transaction_notification_modun.dart';

class Transaction_Notification extends StatelessWidget {
  const Transaction_Notification({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Transaction_Notification_Modun(size: size),
          Transaction_Notification_Modun(size: size),
          Transaction_Notification_Modun(size: size),
          Transaction_Notification_Modun(size: size),
          Transaction_Notification_Modun(size: size),
        ],
      ),
    );
  }
}
