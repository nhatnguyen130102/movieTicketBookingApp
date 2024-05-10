import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_1/model/location_model.dart';
import 'package:project_1/repository/location_repository.dart';

import '../../../component_widget/loading.dart';
import '../../../style/style.dart';
import '../AD_sidebar.dart';
import 'detail_location.dart';

class MainLocation extends StatefulWidget {
  MainLocation({super.key});

  @override
  State<MainLocation> createState() => _MainLocationState();
}

class _MainLocationState extends State<MainLocation> {
  //repo
  LocationRepository _locationRepository = LocationRepository();

  //var
  late Future<List<LocationModel>> _listLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _listLocation = _locationRepository.getAllLocations();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SidebarPage(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder(
          future: _listLocation,
          builder: (context, screeningSS) {
            if (screeningSS.connectionState == ConnectionState.waiting) {
              return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
            } else if (screeningSS.hasError) {
              return Text('Error: ${screeningSS.error}'); // Xử lý lỗi nếu có
            } else if (screeningSS.data == null) {
              return Text('No data available'); // Xử lý khi không có dữ liệu
            } else {
              return Container(
                width: size.width,
                height: size.height,
                child: ListView.builder(
                  itemCount: screeningSS.data!.length,
                  itemBuilder: (context, index) {
                    LocationModel _modun = screeningSS.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailLocation(
                              locationID: _modun.locationID,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          color: white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _modun.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  Gap(4),
                                  Text(
                                    _modun.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: medium,
                                      color: white.withOpacity(0.5),
                                    ),
                                  ),

                                  Gap(16),

                                  //Quick Info

                                  //Text here
                                ],
                              ),
                            ),

                            //Edit Button
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
