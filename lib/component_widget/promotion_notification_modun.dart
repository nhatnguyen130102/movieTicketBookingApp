import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Promotion_Notification_Modun extends StatelessWidget {
  const Promotion_Notification_Modun({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 150,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 186, 186, 186),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
          ),
          Container(
            height: 150,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '08:32 AM - 05/03/2024',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400]),
                    ),
                  ),
                  Gap(15),
                  Container(
                    child: Text(
                      'YOU HAVE A GIFT FROM CINEONE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Gap(10),
                  Container(
                    child: Text(
                      'asdfasdflasdfaslkdjflaafsdfasdfasdfasdfasflasdfaslkddfasdflasdfaslkdjflaafsdfasdfasdfasdfasflasdfaslkdjflaafsdfasdfasdfasdfasdfasdfasdfjflaafsdfasdfasdfasdfasdfasdfasdfasddfasflasdfaslkdjflaafsdfasdfasdfasdfasdfasdfasdfasddfasdfasdfasdf',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
