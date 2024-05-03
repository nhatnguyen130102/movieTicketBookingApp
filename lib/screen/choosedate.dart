import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:project_1/model/movie_model.dart';
import 'package:project_1/model/screening_model.dart';
import 'package:project_1/repository/cinema_repository.dart';
import 'package:project_1/repository/movie_repository.dart';
import 'package:project_1/repository/screening_repository.dart';
import 'package:project_1/screen/chooseseat.dart';
import 'package:project_1/style/style.dart';
import 'package:heroicons/heroicons.dart';

import '../component_widget/loading.dart';
import '../model/cinema_model.dart';

class Choose_Date extends StatefulWidget {
  late String movieID;
  late String cinemaID;
  late String locationID;

  Choose_Date(
      {required this.locationID,
      required this.cinemaID,
      required this.movieID,
      super.key});

  @override
  State<Choose_Date> createState() => _Choose_DateState();
}

class _Choose_DateState extends State<Choose_Date> {
  // repository
  MovieRepository _movieRepository = MovieRepository();
  CinemaRepository _cinemaRepository = CinemaRepository();
  Screening_Repository _screening_repository = Screening_Repository();

  // var
  late Future<MovieModel?> _movie;
  late Future<CinemaModel?> _cinema;
  late Future<List<ScreeningModel>> _listScreening;
  String todayFormat = DateFormat('dd/MM/yyyy').format(DateTime.now());
  late int _dateSelected = 0;

  @override
  void initState() {
    super.initState();
    _movie = _movieRepository.getMoviesByMovieID(widget.movieID);
    _cinema = _cinemaRepository.getCinemaByID(widget.cinemaID);
    _listScreening = _screening_repository.getScreeningByMovieIDDateCinemaID(
        widget.movieID, todayFormat, widget.cinemaID);
  }

  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<DateTime> next14Days = [];
    for (int i = 0; i <= 13; i++) {
      DateTime nextDay = now.add(Duration(days: i));
      next14Days.add(nextDay);
    }

    DateFormat getDateTime = DateFormat('dd/MM/yyyy');
    DateFormat getDate = DateFormat('dd');
    DateFormat getMon = DateFormat('MM');
    DateFormat getE = DateFormat('E');

    List<String> formatDateTime =
        next14Days.map((day) => getDateTime.format(day)).toList();
    List<String> formatDate =
        next14Days.map((day) => getDate.format(day)).toList();
    List<String> formatMon =
        next14Days.map((day) => getMon.format(day)).toList();
    List<String> formatE = next14Days.map((day) => getE.format(day)).toList();

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
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Date-list
              Container(
                width: size.width,
                height: 112,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: formatDateTime.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _dateSelected = index;
                          todayFormat = formatDateTime[index];
                          _listScreening = _screening_repository
                              .getScreeningByMovieIDDateCinemaID(
                                  widget.movieID, todayFormat, widget.cinemaID);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.symmetric(vertical: 8),
                        width: 72,
                        height: 112,
                        decoration: BoxDecoration(
                          color: _dateSelected == index
                              ? Colors.yellow
                              : white.withOpacity(0.1),
                          // color: white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                //Days of week
                                formatE[index].toUpperCase(),
                                style: TextStyle(
                                  color: _dateSelected == index
                                      ? Colors.black
                                      : white.withOpacity(0.9),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                //Date
                                formatDate[index],

                                style: TextStyle(
                                  color: _dateSelected == index
                                      ? Colors.black
                                      : white.withOpacity(0.9),
                                  fontWeight: semibold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                //Month
                                formatMonth.convertToMonthName(
                                  formatMon[index],
                                ),
                                style: TextStyle(
                                  color: _dateSelected == index
                                      ? Colors.black
                                      : white.withOpacity(0.9),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Gap(24),

              //Selected-movie
              FutureBuilder(
                future: _movie,
                builder: (context, SnapShot) {
                  if (SnapShot.connectionState == ConnectionState.waiting) {
                    return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                  } else if (SnapShot.hasError) {
                    return Text('Error: ${SnapShot.error}'); // Xử lý lỗi nếu có
                  } else if (SnapShot.data == null) {
                    return Text(
                        'No data available'); // Xử lý khi không có dữ liệu
                  } else {
                    return Container(
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: 120 * 1.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                SnapShot.data!.image, width: 200,
                                // Độ rộng của hình ảnh
                                height: 200,
                                // Chiều cao của hình ảnh
                                fit: BoxFit
                                    .cover, // Cách hiển thị hình ảnh bên trong ClipRRect
                              ),
                            ),
                          ),
                          Gap(20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    SnapShot.data!.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: yellow,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Gap(2),
                                Container(
                                  child: Text(
                                    SnapShot.data!.genre,
                                    style: TextStyle(
                                      color: white.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                Gap(16),
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          HeroIcon(
                                            HeroIcons.clock,
                                            color: yellow,
                                          ),
                                          Gap(6),
                                          Text(
                                            SnapShot.data!.time,
                                            style: TextStyle(
                                              fontWeight: medium,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(40),
                                      Row(
                                        children: [
                                          HeroIcon(
                                            HeroIcons.film,
                                            color: yellow,
                                          ),
                                          Gap(10),
                                          Text(
                                            SnapShot.data!.age,
                                            style: TextStyle(
                                              fontWeight: medium,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(8),
                                Container(
                                  child: Row(
                                    children: [
                                      HeroIcon(
                                        HeroIcons.star,
                                        color: yellow,
                                      ),
                                      Gap(8),
                                      Text(
                                        SnapShot.data!.rating.toString(),
                                        style: TextStyle(
                                          fontWeight: medium,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  ;
                },
              ),
              Gap(24),

              //Selected-cinema
              FutureBuilder(
                future: _cinema,
                builder: (context, SnapShot) {
                  if (SnapShot.connectionState == ConnectionState.waiting) {
                    return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                  } else if (SnapShot.hasError) {
                    return Text('Error: ${SnapShot.error}'); // Xử lý lỗi nếu có
                  } else if (SnapShot.data == null) {
                    return Text(
                        'No data available'); // Xử lý khi không có dữ liệu
                  } else {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    SnapShot.data!.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: yellow,
                                      fontWeight: medium,
                                    ),
                                  ),
                                ),
                                Gap(4),
                                Container(
                                  child: Text(
                                    '1.8 km',
                                    style: TextStyle(fontWeight: medium),
                                  ),
                                ),
                              ],
                            ),
                            HeroIcon(
                              HeroIcons.chevronDown,
                              color: yellow,
                            ),
                          ],
                        ),
                        Gap(16),
                        Row(
                          children: [
                            HeroIcon(
                              HeroIcons.mapPin,
                              color: white.withOpacity(0.5),
                              size: 24,
                            ),
                            Gap(6),
                            Container(
                              width: size.width - 60,
                              child: Text(
                                SnapShot.data!.address,
                                style: TextStyle(
                                  color: white.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(16),
                        Row(
                          children: [
                            HeroIcon(
                              HeroIcons.devicePhoneMobile,
                              color: white.withOpacity(0.5),
                              size: 22,
                            ),
                            Gap(6),
                            Text(
                              '+ 84 98 112 56 32',
                              style: TextStyle(
                                color: white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                  ;
                },
              ),
              Gap(24),

              //Screening-list
              Container(
                width: size.width,
                height: 160,
                child: FutureBuilder(
                  future: _listScreening,
                  builder: (context, SnapShot) {
                    if (SnapShot.connectionState == ConnectionState.waiting) {
                      return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                    } else if (SnapShot.hasError) {
                      return Text(
                          'Error: ${SnapShot.error}'); // Xử lý lỗi nếu có
                    } else if (SnapShot.data == null) {
                      return Text(
                          'No data available'); // Xử lý khi không có dữ liệu
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: SnapShot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChooseSeat(
                                          cinemaID: widget.cinemaID,
                                          movieID: widget.movieID,
                                          locationID: widget.locationID,
                                          screeningID: SnapShot
                                              .data![index].screeningID,),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 16),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              width: 128,
                              height: 160,
                              decoration: BoxDecoration(
                                color: white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '4DX',
                                        style: TextStyle(
                                          color: white.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                      Gap(16),
                                      Text(
                                        SnapShot.data![index].time
                                            .substring(0, 5),
                                        style: TextStyle(
                                          fontWeight: medium,
                                          fontSize: 32,
                                        ),
                                      ),
                                      Gap(8),
                                      Text(
                                        'Room ' + SnapShot.data![index].room,
                                        style: TextStyle(
                                          fontWeight: medium,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Gap(16),
                                      Container(
                                        width: 100,
                                        child: LinearProgressIndicator(
                                          value: 0.8,
                                          minHeight: 3.0,
                                          backgroundColor:
                                              white.withOpacity(0.1),
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  yellow),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    ;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class formatMonth {
  static List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];

  static String convertToMonthName(String monthIndex) {
    if (monthIndex == '01') {
      return months[0];
    }
    if (monthIndex == '02') {
      return months[1];
    }
    if (monthIndex == '03') {
      return months[2];
    }
    if (monthIndex == '04') {
      return months[3];
    }
    if (monthIndex == '05') {
      return months[4];
    }
    if (monthIndex == '06') {
      return months[5];
    }
    if (monthIndex == '07') {
      return months[6];
    }
    if (monthIndex == '08') {
      return months[7];
    }
    if (monthIndex == '09') {
      return months[8];
    }
    if (monthIndex == '10') {
      return months[9];
    }
    if (monthIndex == '11') {
      return months[10];
    }
    if (monthIndex == '12') {
      return months[11];
    } else {
      return '';
    }
  }
}
