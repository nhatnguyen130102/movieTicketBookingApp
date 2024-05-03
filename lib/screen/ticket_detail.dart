//y chang Billing
//nút Confirm đổi thành Save
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';

import '../style/style.dart';
class TicketDetail extends StatefulWidget {
  const TicketDetail({super.key});

  @override
  State<TicketDetail> createState() => _TicketDetailState();
}

class _TicketDetailState extends State<TicketDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        body: Column(
          children: [

            //Billing info

            //Rating system

            //Write review
            Gap(24),
            Container(
              width: size.width,
              child: TextFormField(
                //controller: _valueController,
                style: TextStyle(color: white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Write a review',
                  label: Text('Review'),
                  hintStyle: TextStyle(
                      color: white.withOpacity(0.6), fontWeight: light),
                  filled: true,
                  fillColor: white.withOpacity(0.1),
                  prefixIconColor: white,
                ),
              ),
            ),
          ],
        )
    );
  }
}
