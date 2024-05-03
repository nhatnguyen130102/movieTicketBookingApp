import 'package:flutter/material.dart';

import 'promotion_notification_modun.dart';

class Promotion_Notification extends StatelessWidget {
  final Size size;
  const Promotion_Notification({
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Promotion_Notification_Modun(size: size),
          Promotion_Notification_Modun(size: size),
          Promotion_Notification_Modun(size: size),
        ],
      ),
    );
  }
}
