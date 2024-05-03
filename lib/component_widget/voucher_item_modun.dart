import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_1/style/style.dart';

class voucher_item_modun extends StatelessWidget {
  const voucher_item_modun({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      height: 140,
      width: size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            width: 140,
            height: 140,
            color: const Color.fromARGB(255, 223, 223, 223),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Heading
                        Text(
                          'Heading',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(5),

                        //Title
                        Text(
                          'Title',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(10),

                        //voucher-discount
                        Container(
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                margin: EdgeInsets.only(
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: white,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    'Voucher ${index}',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                ),
                Text(
                  'Bottom line',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Icon(
              Icons.bookmark_border,
              size: 30,
              color: white,
            ),
          ),
        ],
      ),
    );
  }
}
