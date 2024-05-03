import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class movie_orders extends StatelessWidget {
  const movie_orders({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 15),
      width: size.width * 0.9,
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 224, 224, 224),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Movie Name',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'TUE 04/04/2024 - 08:00 PM',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Text(
                  '\$0.00',
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 60),
            child: GestureDetector(
              onTap: () {},
              child: Icon(FontAwesome.trash),
            ),
          ),
        ],
      ),
    );
  }
}
