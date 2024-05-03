import 'package:flutter/material.dart';

import 'infomation_notification_modun.dart';

class Infomation_Notification extends StatelessWidget {
  final Size size;
  const Infomation_Notification({
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Infomation_Notification_Modun(size: size),
          Infomation_Notification_Modun(size: size),
          Infomation_Notification_Modun(size: size),
          Infomation_Notification_Modun(size: size),
          Infomation_Notification_Modun(size: size),
        ],
      ),
    );
  }
}
