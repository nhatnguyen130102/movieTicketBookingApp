import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../style/style.dart';

import 'package:heroicons/heroicons.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: HeroIcon(
            HeroIcons.chevronLeft,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            //Ticket-Item
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //Movie-Details
                children: [
                  Container(
                    width: size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Movie-Name
                        Row(
                          children: [
                            Text('TAROT', style: TextStyle(fontSize: 16, fontWeight: bold,),)
                          ],
                        ),
                        Gap(12),

                        //Movie-Info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: yellow, size: 12,),
                                    Gap(4),
                                    Text('4.9', style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                  ],
                                ),
                                Gap(8),
                                Row(
                                  children: [
                                    Icon(Icons.schedule, color: yellow, size: 12,),
                                    Gap(4),
                                    Text('115', style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                  ],
                                ),
                                Gap(8),
                                Row(
                                  children: [
                                    Icon(Icons.movie, color: yellow, size: 12,),
                                    Gap(4),
                                    Text('T16', style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: size.width / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SWEETBOX',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                  Gap(8),
                                  Text(
                                    '12/02/2024',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                  Gap(8),
                                  Text(
                                    '08:30 AM',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                  //Details-Button
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('DETAILS', style: TextStyle(fontSize: 10, fontWeight: bold, color: black),),
                  ),
                ],
              ),
            ),
            Gap(16),

            //Ticket-Item
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //Movie-Details
                children: [
                  Container(
                    width: size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Movie-Name
                        Row(
                          children: [
                            Text('TAROT', style: TextStyle(fontSize: 16, fontWeight: bold,),)
                          ],
                        ),
                        Gap(12),

                        //Movie-Info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: yellow, size: 12,),
                                    Gap(4),
                                    Text('4.9', style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                  ],
                                ),
                                Gap(8),
                                Row(
                                  children: [
                                    Icon(Icons.schedule, color: yellow, size: 12,),
                                    Gap(4),
                                    Text('115', style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                  ],
                                ),
                                Gap(8),
                                Row(
                                  children: [
                                    Icon(Icons.movie, color: yellow, size: 12,),
                                    Gap(4),
                                    Text('T16', style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: size.width / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SWEETBOX',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                  Gap(8),
                                  Text(
                                    '12/02/2024',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                  Gap(8),
                                  Text(
                                    '08:30 AM',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 10, fontWeight: medium,),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                  //Details-Button
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('DETAILS', style: TextStyle(fontSize: 10, fontWeight: bold, color: black),),
                  ),
                ],
              ),
            ),

            //Ticket-Item
            //Ticket-Item
            //Ticket-Item
          ],
        ),
      ),
    );
  }
}
