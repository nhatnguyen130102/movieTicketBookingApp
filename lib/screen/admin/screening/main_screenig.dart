import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_1/model/movie_model.dart';
import 'package:project_1/repository/cinema_repository.dart';
import 'package:project_1/repository/movie_repository.dart';
import 'package:project_1/repository/screening_repository.dart';
import 'package:project_1/screen/admin/movie/detail_movie.dart';
import 'package:project_1/screen/admin/screening/create_screening.dart';

import '../../../component_widget/loading.dart';
import '../../../model/screening_model.dart';
import '../../../style/style.dart';
import 'detail_screening.dart';

class MainScreening extends StatefulWidget {
  String movieID;

  MainScreening({required this.movieID, super.key});

  @override
  State<MainScreening> createState() => _MainScreeningState();
}

class _MainScreeningState extends State<MainScreening> {
  //repo
  Screening_Repository _screening_repository = Screening_Repository();
  MovieRepository _movieRepository = MovieRepository();
  CinemaRepository _cinemaRepository = CinemaRepository();

  //var
  late Future<List<ScreeningModel>> _listScreening;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listScreening =
        _screening_repository.getScreeningByMovieID(widget.movieID);
    setState(() {});
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
                builder: (context) => DetailMovie(movieID: widget.movieID),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder(
          future: _listScreening,
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
                    ScreeningModel _screeningModun = screeningSS.data![index];
                    return FutureBuilder(
                      future: _movieRepository
                          .getMoviesByMovieID(_screeningModun.movieID),
                      builder: (context, movieSnapShot) {
                        if (movieSnapShot.connectionState ==
                            ConnectionState.waiting) {
                          return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                        } else if (movieSnapShot.hasError) {
                          return Text(
                              'Error: ${movieSnapShot.error}'); // Xử lý lỗi nếu có
                        } else if (movieSnapShot.data == null) {
                          return Text(
                              'No data available'); // Xử lý khi không có dữ liệu
                        } else {
                          MovieModel _movieModun = movieSnapShot.data!;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreening(
                                    screeningID: _screeningModun.screeningID,
                                    movieID: _movieModun.movieID,
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
                                    width: size.width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _movieModun.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: bold,
                                          ),
                                        ),
                                        Gap(4),
                                        FutureBuilder(
                                          future:
                                              _cinemaRepository.getCinemaByID(
                                                  _screeningModun.cinemaID),
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
                                              return Text(
                                                cinemaSnapShot.data!.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: medium,
                                                  color: white.withOpacity(0.5),
                                                ),
                                              );
                                            }
                                          },
                                        ),

                                        Gap(16),

                                        //Quick Info
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: yellow, size: 14),
                                            Gap(8),
                                            Text(
                                              _screeningModun.date +
                                                  '-' +
                                                  _screeningModun.time,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                                              'Room: ' + _screeningModun.room,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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

                                  //Edit Button
                                ],
                              ),
                            ),
                          );
                        }
                        ;
                      },
                    );
                  },
                ),
              );
            }
          },
        ),
      ),

      //Create New - Add button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateScreening()),
          );
        },
        shape: CircleBorder(),
        foregroundColor: pink,
        backgroundColor: pink.withOpacity(0.2),
        child: const Icon(Icons.add),
      ),
    );
  }
}
