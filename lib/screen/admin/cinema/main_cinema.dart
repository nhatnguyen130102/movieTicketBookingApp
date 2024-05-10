import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_1/repository/location_repository.dart';
import 'package:project_1/screen/admin/cinema/detail_cinema.dart';

import '../../../component_widget/loading.dart';
import '../../../model/cinema_model.dart';
import '../../../repository/cinema_repository.dart';
import '../../../style/style.dart';
import '../AD_sidebar.dart';

class MainCinema extends StatefulWidget {
  const MainCinema({super.key});

  @override
  State<MainCinema> createState() => _MainCinemaState();
}

class _MainCinemaState extends State<MainCinema> {
  //repo
  CinemaRepository _formatRepository = CinemaRepository();
  LocationRepository _locationRepository = LocationRepository();

  //var
  late Future<List<CinemaModel>> _listFormat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _listFormat = _formatRepository.getAllCinema();
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
          future: _listFormat,
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
                    CinemaModel _modun = screeningSS.data![index];
                    return FutureBuilder(
                      future: _locationRepository
                          .getLocationByID(_modun.locationID),
                      builder: (context, locationSS) {
                        if (locationSS.connectionState ==
                            ConnectionState.waiting) {
                          return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                        } else if (locationSS.hasError) {
                          return Text(
                              'Error: ${locationSS.error}'); // Xử lý lỗi nếu có
                        } else if (locationSS.data == null) {
                          return Text(
                              'No data available'); // Xử lý khi không có dữ liệu
                        } else {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailCinema(
                                    cinemaID: _modun.cinemaID,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width * 0.8,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          _modun.address,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: medium,
                                            color: white.withOpacity(0.5),
                                          ),
                                        ),

                                        Gap(16),

                                        Row(
                                          children: [
                                            Container(
                                              width: size.width * 0.7,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  //Quick Info
                                                  Row(
                                                    children: [
                                                      Icon(Icons.star,
                                                          color: yellow, size: 14),
                                                      Gap(8),
                                                      Text(
                                                        locationSS.data!.name,
                                                        maxLines: 1,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontWeight: medium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Gap(8),

                                                  //Quick Info
                                                  Row(
                                                    children: [
                                                      Icon(Icons.star,
                                                          color: yellow, size: 14),
                                                      Gap(8),
                                                      Text(
                                                        _modun.latitude.toString(),
                                                        maxLines: 1,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontWeight: medium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Gap(8),

                                                  //Quick Info
                                                  Row(
                                                    children: [
                                                      Icon(Icons.star,
                                                          color: yellow, size: 14),
                                                      Gap(8),
                                                      Text(
                                                        _modun.longitude.toString(),
                                                        maxLines: 1,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontWeight: medium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  //Text here
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  //Edit Button
                                ],
                              ),
                            ),
                          );
                        }
                      },
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
