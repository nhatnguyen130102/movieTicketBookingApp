import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_1/repository/voucher_repository.dart';
import 'package:selection_menu/components_configurations.dart';

import '../component_widget/loading.dart';
import '../model/voucher_model.dart';
import '../style/style.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  //repo
  VoucherRepository _voucherRepository = VoucherRepository();

  //var
  late Future<List<VoucherModel>?> _listVoucher;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listVoucher = _voucherRepository.getAllVouchers();
  }

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
            FutureBuilder(
              future: _listVoucher,
              builder: (context, voucherSnapShot) {
                if (voucherSnapShot.connectionState == ConnectionState.waiting) {
                  return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                } else if (voucherSnapShot.hasError) {
                  return Text(
                      'Error: ${voucherSnapShot.error}'); // Xử lý lỗi nếu có
                } else if (voucherSnapShot.data == null) {
                  return Text(
                      'No data available'); // Xử lý khi không có dữ liệu
                } else {

                  return Container(
                    height: size.height,
                    width:  size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: voucherSnapShot.data!.length,
                      itemBuilder: (context,index){
                        VoucherModel _voucherModun = voucherSnapShot.data![index];
                        return  Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(bottom: 16),
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
                                    //Movie-Info
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: yellow.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Icon(Icons.favorite_border,
                                              color: yellow, size: 24),
                                        ),
                                        Container(
                                          width: size.width / 3,
                                          padding: EdgeInsets.only(left: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _voucherModun.heading,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: bold,
                                                ),
                                              ),
                                              Gap(4),
                                              Text(
                                                'Valid until '+ _voucherModun.validDate,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: white.withOpacity(0.5)),
                                              ),
                                              Gap(8),
                                              Text(
                                                _voucherModun.body,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: medium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              //Get-Button
                              GestureDetector(
                                onTap: (){
                                  _voucherModun.status ? null : null;
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color:_voucherModun.status ? yellow : white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    'GET',
                                    style:  TextStyle(
                                        fontSize: 10, fontWeight: bold, color: black) ,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            // //Voucher-Item
            // Container(
            //   padding: EdgeInsets.all(16),
            //   margin: EdgeInsets.only(bottom: 16),
            //   decoration: BoxDecoration(
            //     color: white.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //Movie-Details
            //     children: [
            //       Container(
            //         width: size.width / 2,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             //Movie-Info
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Container(
            //                   padding: EdgeInsets.all(16),
            //                   decoration: BoxDecoration(
            //                     color: yellow.withOpacity(0.1),
            //                     borderRadius: BorderRadius.circular(10),
            //                   ),
            //                   child: Icon(Icons.favorite_border,
            //                       color: yellow, size: 24),
            //                 ),
            //                 Container(
            //                   width: size.width / 3,
            //                   padding: EdgeInsets.only(left: 8),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         'Free Drinks',
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(
            //                           fontSize: 16,
            //                           fontWeight: bold,
            //                         ),
            //                       ),
            //                       Gap(4),
            //                       Text(
            //                         'Valid until 12/05/2024',
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(
            //                             fontSize: 10,
            //                             color: white.withOpacity(0.5)),
            //                       ),
            //                       Gap(8),
            //                       Text(
            //                         'For couple tickets only',
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(
            //                           fontSize: 12,
            //                           fontWeight: medium,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //
            //       //Get-Button
            //       Container(
            //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            //         decoration: BoxDecoration(
            //           color: yellow,
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: Text(
            //           'GET',
            //           style: TextStyle(
            //               fontSize: 10, fontWeight: bold, color: black),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            //
            // //Voucher-Item
            // Container(
            //   padding: EdgeInsets.all(16),
            //   margin: EdgeInsets.only(bottom: 16),
            //   decoration: BoxDecoration(
            //     color: white.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //Movie-Details
            //     children: [
            //       Container(
            //         width: size.width / 2,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             //Movie-Info
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Container(
            //                   padding: EdgeInsets.all(16),
            //                   decoration: BoxDecoration(
            //                     color: yellow.withOpacity(0.1),
            //                     borderRadius: BorderRadius.circular(10),
            //                   ),
            //                   child: Icon(Icons.favorite_border,
            //                       color: yellow, size: 24),
            //                 ),
            //                 Container(
            //                   width: size.width / 3,
            //                   padding: EdgeInsets.only(left: 8),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         'Free Drinks',
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(
            //                           fontSize: 16,
            //                           fontWeight: bold,
            //                         ),
            //                       ),
            //                       Gap(4),
            //                       Text(
            //                         'Valid until 12/05/2024',
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(
            //                             fontSize: 10,
            //                             color: white.withOpacity(0.5)),
            //                       ),
            //                       Gap(8),
            //                       Text(
            //                         'For couple tickets only ',
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(
            //                           fontSize: 12,
            //                           fontWeight: medium,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //
            //       //Get-Button
            //       Container(
            //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            //         decoration: BoxDecoration(
            //           color: white.withOpacity(0.1),
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: Text(
            //           'GET',
            //           style: TextStyle(
            //               fontSize: 10, fontWeight: bold, color: black),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            //Voucher-Item
            //Voucher-Item
          ],
        ),
      ),
    );
  }
}
