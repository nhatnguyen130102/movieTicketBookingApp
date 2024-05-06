import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_1/model/movie_model.dart';
import 'package:project_1/model/user_model.dart';
import 'package:project_1/repository/cinema_repository.dart';
import 'package:project_1/repository/movie_repository.dart';
import 'package:project_1/repository/screening_repository.dart';
import 'package:project_1/repository/user_repository.dart';
import 'package:project_1/screen/ticket_detail.dart';

import '../component_widget/loading.dart';
import '../model/screening_model.dart';
import '../style/style.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
//repo
  UserRepository _userRepository = UserRepository();
  MovieRepository _movieRepository = MovieRepository();
  Screening_Repository _screening_repository = Screening_Repository();
  CinemaRepository _cinemaRepository = CinemaRepository();

//var
  late Future<List<BookingItem>?> _listBooking;
  late String _userID = '';
  late bool isLogin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfUserIsLoggedIn();
    isLogin ? _listBooking = _userRepository.historyTicket(_userID) : null;
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
            isLogin
                ?
                //Ticket-Item
                FutureBuilder(
                    future: _listBooking,
                    builder: (context, itemBooking) {
                      if (itemBooking.connectionState ==
                          ConnectionState.waiting) {
                        return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                      } else if (itemBooking.hasError) {
                        return Text(
                            'Error: ${itemBooking.error}'); // Xử lý lỗi nếu có
                      } else if (itemBooking.data == null) {
                        return Text(
                            'No data available 1'); // Xử lý khi không có dữ liệu
                      } else {
                        List<BookingItem> _bookingModun = itemBooking.data!;
                        return Container(
                          width: size.width,
                          height: size.height,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: _bookingModun.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                future: _screening_repository.getScreeningByID(
                                    _bookingModun[index].screeningID),
                                builder: (context, screeningSnapShot) {
                                  if (screeningSnapShot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                                  } else if (screeningSnapShot.hasError) {
                                    return Text(
                                        'Error: ${screeningSnapShot.error}'); // Xử lý lỗi nếu có
                                  } else if (screeningSnapShot.data == null) {
                                    return Text(
                                        'No data available 2'); // Xử lý khi không có dữ liệu
                                  } else {
                                    ScreeningModel _screeningModun =
                                        screeningSnapShot.data!;
                                    return FutureBuilder(
                                      future:
                                          _movieRepository.getMoviesByMovieID(
                                              _bookingModun[index].movieID),
                                      builder: (context, movieSnapShot) {
                                        if (movieSnapShot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                                        } else if (movieSnapShot.hasError) {
                                          return Text(
                                              'Error: ${movieSnapShot.error}'); // Xử lý lỗi nếu có
                                        } else if (movieSnapShot.data == null) {
                                          return Text(
                                              'No data available 3'); // Xử lý khi không có dữ liệu
                                        } else {
                                          MovieModel _movieModun =
                                              movieSnapShot.data!;

                                          return Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: white.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              //Movie-Details
                                              children: [
                                                Container(
                                                  width: size.width / 1.6,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //Movie-Name
                                                      Row(
                                                        children: [
                                                          Text(
                                                            _movieModun.name,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: bold,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Gap(12),

                                                      //Movie-Info
                                                      Row(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.star,
                                                                    color:
                                                                        yellow,
                                                                    size: 12,
                                                                  ),
                                                                  Gap(4),
                                                                  Text(
                                                                    _movieModun
                                                                        .rating
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          medium,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Gap(8),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .schedule,
                                                                    color:
                                                                        yellow,
                                                                    size: 12,
                                                                  ),
                                                                  Gap(4),
                                                                  Text(
                                                                    _movieModun
                                                                        .time,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          medium,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Gap(8),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.movie,
                                                                    color:
                                                                        yellow,
                                                                    size: 12,
                                                                  ),
                                                                  Gap(4),
                                                                  Text(
                                                                    _movieModun
                                                                        .age,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          medium,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Gap(20),
                                                          Container(
                                                            width: size.width /
                                                                2.3,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                FutureBuilder(
                                                                  future: _cinemaRepository
                                                                      .getCinemaByID(
                                                                          _screeningModun
                                                                              .cinemaID),
                                                                  builder: (context,
                                                                      _cinemaSnapShot) {
                                                                    if (_cinemaSnapShot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                                                                    } else if (_cinemaSnapShot
                                                                        .hasError) {
                                                                      return Text(
                                                                          'Error: ${_cinemaSnapShot.error}'); // Xử lý lỗi nếu có
                                                                    } else if (_cinemaSnapShot
                                                                            .data ==
                                                                        null) {
                                                                      return Text(
                                                                          'No data available 3'); // Xử lý khi không có dữ liệu
                                                                    } else {
                                                                      return Text(
                                                                        _cinemaSnapShot
                                                                            .data!
                                                                            .name,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              medium,
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                                Gap(8),
                                                                Text(
                                                                  'Room: ' +
                                                                      _screeningModun
                                                                          .room,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        medium,
                                                                  ),
                                                                ),
                                                                Gap(8),
                                                                Text(
                                                                  _screeningModun
                                                                          .date +
                                                                      ' - ' +
                                                                      _screeningModun
                                                                          .time,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        medium,
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

                                                //Details-Button
                                                Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                Ticket_Detail(
                                                              screeningID:
                                                                  _screeningModun
                                                                      .screeningID,
                                                              movieID: _movieModun
                                                                  .movieID,
                                                              bookingID:
                                                                  _bookingModun[
                                                                          index]
                                                                      .bookingID,
                                                              userID: _userID,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                                vertical: 8),
                                                        decoration: BoxDecoration(
                                                          color: yellow,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  5),
                                                        ),
                                                        child: Text(
                                                          'DETAILS',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight: bold,
                                                              color: black),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      _bookingModun[index].total.toString(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        ;
                                      },
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        );
                      }
                    },
                  )
                : Text('Đăng nhập để xem lịch sử mua vé'),
            //Ticket-Item
            // Container(
            //   padding: EdgeInsets.all(16),
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
            //             //Movie-Name
            //             Row(
            //               children: [
            //                 Text('TAROT', style: TextStyle(fontSize: 16, fontWeight: bold,),)
            //               ],
            //             ),
            //             Gap(12),
            //
            //             //Movie-Info
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Row(
            //                       children: [
            //                         Icon(Icons.star, color: yellow, size: 12,),
            //                         Gap(4),
            //                         Text('4.9', style: TextStyle(fontSize: 10, fontWeight: medium,),),
            //                       ],
            //                     ),
            //                     Gap(8),
            //                     Row(
            //                       children: [
            //                         Icon(Icons.schedule, color: yellow, size: 12,),
            //                         Gap(4),
            //                         Text('115', style: TextStyle(fontSize: 10, fontWeight: medium,),),
            //                       ],
            //                     ),
            //                     Gap(8),
            //                     Row(
            //                       children: [
            //                         Icon(Icons.movie, color: yellow, size: 12,),
            //                         Gap(4),
            //                         Text('T16', style: TextStyle(fontSize: 10, fontWeight: medium,),),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //                 Container(
            //                   width: size.width / 4,
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         'SWEETBOX',
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(fontSize: 10, fontWeight: medium,),),
            //                       Gap(8),
            //                       Text(
            //                         '12/02/2024',
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(fontSize: 10, fontWeight: medium,),),
            //                       Gap(8),
            //                       Text(
            //                         '08:30 AM',
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: TextStyle(fontSize: 10, fontWeight: medium,),),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //
            //
            //       //Details-Button
            //       Container(
            //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            //         decoration: BoxDecoration(
            //           color: yellow,
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: Text('DETAILS', style: TextStyle(fontSize: 10, fontWeight: bold, color: black),),
            //       ),
            //     ],
            //   ),
            // ),

            //Ticket-Item
            //Ticket-Item
            //Ticket-Item
          ],
        ),
      ),
    );
  }
}
