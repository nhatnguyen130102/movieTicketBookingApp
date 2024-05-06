import 'dart:math';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:project_1/model/cinema_model.dart';
import 'package:project_1/repository/booking_repository.dart';
import 'package:project_1/repository/cinema_repository.dart';
import 'package:project_1/repository/format.dart';
import 'package:project_1/repository/movie_repository.dart';
import 'package:project_1/repository/screening_repository.dart';
import 'package:project_1/screen/mainlayout.dart';

import '../component_widget/loading.dart';
import '../model/format_model.dart';
import '../model/movie_model.dart';
import '../model/screening_model.dart';
import '../repository/user_repository.dart';
import '../style/style.dart';

class Ticket_Detail extends StatefulWidget {
  String movieID;
  String screeningID;
  String bookingID;
  String userID;

  Ticket_Detail(
      {required this.screeningID,
      required this.movieID,
      required this.bookingID,
      required this.userID,
      super.key});

  @override
  State<Ticket_Detail> createState() => _BillingPageState();
}

class _BillingPageState extends State<Ticket_Detail> {
  // repository
  Screening_Repository _screening_repository = Screening_Repository();
  MovieRepository _movieRepository = MovieRepository();
  FormatRepository _formatRepository = FormatRepository();
  BookingRepository _bookingRepository = BookingRepository();
  CinemaRepository _cinemaRepository = CinemaRepository();
  UserRepository _userRepository = UserRepository();

  // var
  late Future<MovieModel?> _movie;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _userID;
  late bool isLogin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfUserIsLoggedIn();
    _movie = _movieRepository.getMoviesByMovieID(widget.movieID);
  }
  void _checkIfUserIsLoggedIn() async {
    // Kiểm tra xem có người dùng nào đã đăng nhập trước đó hay không
    User? user = _auth.currentUser;
    if (user != null) {
      _userID = FirebaseAuth.instance.currentUser!.uid;
      isLogin = true;
    } else {
      _userID = '';
      isLogin = false;
    }
  }
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
      body: FutureBuilder(
        future: _movie,
        builder: (context, movieSnapShot) {
          if (movieSnapShot.connectionState == ConnectionState.waiting) {
            return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
          } else if (movieSnapShot.hasError) {
            return Text('Error: ${movieSnapShot.error}'); // Xử lý lỗi nếu có
          } else if (movieSnapShot.data == null) {
            return Text('No data available'); // Xử lý khi không có dữ liệu
          } else {
            MovieModel _itemMovie = movieSnapShot.data!;
            return FutureBuilder(
              future:
                  _screening_repository.getScreeningByID(widget.screeningID),
              builder: (context, screeningSnapShot) {
                if (screeningSnapShot.connectionState ==
                    ConnectionState.waiting) {
                  return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                } else if (screeningSnapShot.hasError) {
                  return Text(
                      'Error: ${screeningSnapShot.error}'); // Xử lý lỗi nếu có
                } else if (screeningSnapShot.data == null) {
                  return Text(
                      'No data available'); // Xử lý khi không có dữ liệu
                } else {
                  ScreeningModel _itemScreening = screeningSnapShot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Stack(
                      children: [
                        //Background-banner
                        Positioned(
                          top: 0,
                          left: 20,
                          right: 20,
                          child: Column(
                            children: [
                              //Note-line
                              Text(
                                'Use QR code to pre-show tickets',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: medium,
                                  color: white.withOpacity(0.8),
                                ),
                              ),
                              Gap(12),

                              //Banner-background
                              Container(
                                width: size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    _itemMovie.image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                foregroundDecoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                      black.withOpacity(0.5),
                                      black
                                    ])),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Ticket-info
                        Center(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 64, left: 32, right: 32),
                            child: Column(
                              children: [
                                //QR-code
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: white.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: BarcodeWidget(
                                    barcode: Barcode.qrCode(
                                      errorCorrectLevel:
                                          BarcodeQRCorrectionLevel.high,
                                    ),
                                    data: widget.bookingID,
                                    width: size.width * 0.4,
                                    height: size.width * 0.4,
                                  ),
                                ),
                                Gap(24),

                                //Ticket-details
                                Container(
                                    width: size.width * 0.8,
                                    child: Column(
                                      children: [
                                        Text(
                                          _itemMovie.name,
                                          style: TextStyle(
                                            fontWeight: bold,
                                            fontSize: 28,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Gap(8),
                                        Text(
                                          _itemMovie.genre,
                                          style: TextStyle(
                                            fontWeight: medium,
                                            fontSize: 10,
                                            color: white.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    )),
                                Gap(24),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //ROOM
                                    Column(
                                      children: [
                                        Text(
                                          'ROOM',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: medium,
                                            color: white.withOpacity(0.6),
                                          ),
                                        ),
                                        Gap(4),
                                        Text(
                                          _itemScreening.room,
                                          style: TextStyle(
                                            fontWeight: semibold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),

                                    //FORMAT
                                    FutureBuilder(
                                      future: _formatRepository.getFormatByID(
                                          _itemScreening.formatID),
                                      builder: (context, formatSnapShot) {
                                        if (formatSnapShot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                                        } else if (formatSnapShot.hasError) {
                                          return Text(
                                              'Error: ${formatSnapShot.error}'); // Xử lý lỗi nếu có
                                        } else if (formatSnapShot.data ==
                                            null) {
                                          return Text(
                                              'No data available'); // Xử lý khi không có dữ liệu
                                        } else {
                                          FormatModel _itemFormat =
                                              formatSnapShot.data!;
                                          return Column(
                                            children: [
                                              Text(
                                                'FORMAT',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: medium,
                                                  color: white.withOpacity(0.6),
                                                ),
                                              ),
                                              Gap(4),
                                              Text(
                                                _itemFormat.name.toUpperCase(),
                                                style: TextStyle(
                                                  fontWeight: semibold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        ;
                                      },
                                    ),

                                    //AGE
                                    Column(
                                      children: [
                                        Text(
                                          'AGE',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: medium,
                                            color: white.withOpacity(0.6),
                                          ),
                                        ),
                                        Gap(4),
                                        Text(
                                          // 'T13',
                                          _itemMovie.age,
                                          style: TextStyle(
                                            fontWeight: semibold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Gap(24),

                                //Seat-list
                                Container(
                                  width: size.width * 0.8,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: yellow,
                                        // Specify the border color
                                        width: 2, // Specify the border width
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SEAT',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: bold,
                                          color: yellow,
                                        ),
                                      ),
                                      Gap(8),
                                      FutureBuilder(
                                        future: _userRepository.getBookingUser(
                                            widget.bookingID, widget.userID),
                                        builder: (context, bookedSnapShot) {
                                          if (bookedSnapShot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                                          } else if (bookedSnapShot.hasError) {
                                            return Text(
                                                'Error: ${bookedSnapShot.error}'); // Xử lý lỗi nếu có
                                          } else if (bookedSnapShot.data ==
                                              null) {
                                            return Text(
                                                'No data available'); // Xử lý khi không có dữ liệu
                                          } else {
                                            return  Text(
                                              bookedSnapShot.data!.seat.join(', '),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: semibold,
                                              ),
                                            );
                                          }
                                        },
                                      ),

                                    ],
                                  ),
                                ),
                                Gap(32),

                                Container(
                                  width: size.width * 0.8,
                                  height: 1.5,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    colors: [yellow, Colors.transparent],
                                  )),
                                ),
                                Gap(32),

                                //
                                Container(
                                  width: size.width * 0.8,
                                  child: Column(
                                    children: [
                                      //Datetime
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.date_range,
                                                color: yellow,
                                                size: 14,
                                              ),
                                              Gap(6),
                                              Text(
                                                _itemScreening.date,
                                                style: TextStyle(
                                                    fontWeight: medium,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                color: yellow,
                                                size: 14,
                                              ),
                                              Gap(6),
                                              Text(
                                                _itemScreening.time,
                                                style: TextStyle(
                                                    fontWeight: medium,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Gap(16),
                                      //Address
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: yellow,
                                            size: 14,
                                          ),
                                          Gap(6),
                                          FutureBuilder(
                                            future:
                                                _cinemaRepository.getCinemaByID(
                                                    _itemScreening.cinemaID),
                                            builder: (context, cinemaSnapShot) {
                                              if (cinemaSnapShot
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                                              } else if (cinemaSnapShot
                                                  .hasError) {
                                                return Text(
                                                    'Error: ${cinemaSnapShot.error}'); // Xử lý lỗi nếu có
                                              } else if (cinemaSnapShot.data ==
                                                  null) {
                                                return Text(
                                                    'No data available'); // Xử lý khi không có dữ liệu
                                              } else {
                                                CinemaModel _itemCinema =
                                                    cinemaSnapShot.data!;
                                                return Container(
                                                  width: size.width * 0.7,
                                                  child: Text(
                                                    _itemCinema.address,
                                                    style: TextStyle(
                                                      fontWeight: medium,
                                                      fontSize: 12,
                                                      height: 1.5,
                                                    ),
                                                  ),
                                                );
                                              }
                                              ;
                                            },
                                          ),
                                        ],
                                      ),
                                      Gap(24),

                                      //2-active-buttons
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Container(
                                              width: size.width * 0.4 - 8,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16),
                                              decoration: BoxDecoration(
                                                color: white.withOpacity(0.1),
                                                // border:
                                                //     Border.all(color: yellow, width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                'CANCEL',
                                                style: TextStyle(
                                                  fontWeight: bold,
                                                  fontSize: 14,
                                                  color: yellow,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: size.width * 0.4 - 8,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16),
                                              decoration: BoxDecoration(
                                                color: yellow,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                'CONFIRM',
                                                style: TextStyle(
                                                  fontWeight: bold,
                                                  fontSize: 14,
                                                  color: black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ), //Text-here
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
