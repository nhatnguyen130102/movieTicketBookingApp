import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_1/screen/admin/AD_dashboard.dart';
import 'package:project_1/screen/admin/movie/main_movie.dart';
import 'package:project_1/screen/admin/screening/main_screenig.dart';
import 'package:project_1/screen/admin/user/main_user.dart';
import 'package:project_1/screen/admin/voucher/detail_voucher.dart';

import '../../style/style.dart';

class SidebarPage extends StatefulWidget {
  const SidebarPage({super.key});

  @override
  State<SidebarPage> createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle itemstyle = TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardPage(),
                ),
              );
            },
          ),
          // title: Text('Name movie ${widget.number}'),
        ),
        body: Center(
          child: Column(
            children: [
              Gap(size.width / 6),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Main_User(),
                    ),
                  );
                },
                child: Text(
                  'Users',
                  style: itemstyle,
                ),
              ),
              Gap(64),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Tickets',
                  style: itemstyle,
                ),
              ),
              Gap(16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VoucherEditorPage(),
                    ),
                  );
                },
                child: Text(
                  'Vouchers',
                  style: itemstyle,
                ),
              ),
              Gap(64),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Main_Movie(),
                    ),
                  );
                },
                child: Text(
                  'Movies',
                  style: itemstyle,
                ),
              ),
              Gap(16),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Cinemas',
                  style: itemstyle,
                ),
              ),
              // Gap(16),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => MainScreening(),
              //       ),
              //     );
              //   },
              //   child: Text(
              //     'Screenings',
              //     style: itemstyle,
              //   ),
              // ),
              Gap(64),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Formats',
                  style: itemstyle,
                ),
              ),
              Gap(16),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Locations',
                  style: itemstyle,
                ),
              ),
              Gap(16),
            ],
          ),
        ));
  }
}
