import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_1/model/movie_model.dart';
import 'package:project_1/repository/movie_repository.dart';
import 'package:project_1/screen/rating.dart';

import '../component_widget/loading.dart';
import '../repository/reivew_repository.dart';
import '../style/style.dart';

class ReviewPage extends StatefulWidget {
  String movieID;
  String userID;

  ReviewPage({required this.userID, required this.movieID, super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  //repo
  Review_Repository _reivew_repository = Review_Repository();
  MovieRepository _movieRepository = MovieRepository();

  //var
  double _rating = 0;
  TextEditingController _textEditingController = TextEditingController();
  late Future<MovieModel?> _itemMovie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemMovie = _movieRepository.getMoviesByMovieID(widget.movieID);
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
            Navigator.push(context,MaterialPageRoute(builder: (context)=>RatingPage(movieID: widget.movieID),),);
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder(
              future: _itemMovie ,
              builder: (context, movieSnapShot) {
                if (movieSnapShot.connectionState == ConnectionState.waiting) {
                  return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                } else if (movieSnapShot.hasError) {
                  return Text('Error: ${movieSnapShot.error}'); // Xử lý lỗi nếu có
                } else if (movieSnapShot.data == null) {
                  return Text('No data available'); // Xử lý khi không có dữ liệu
                } else {
                  MovieModel _movieModun = movieSnapShot.data!;
                  return Stack(
                    children: [
                      //Background-banner
                      Positioned(
                        top: 0,
                        left: 20,
                        right: 20,
                        child: Column(
                          children: [
                            //Note-line

                            Gap(12),

                            //Banner-background
                            Container(
                              width: size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _movieModun.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              foregroundDecoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      stops: [
                                        0.1,
                                        0.6
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        black.withOpacity(0.2),
                                        black
                                      ]),
                              ),
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
                          margin: EdgeInsets.only(top: 64, left: 32, right: 32),
                          child: Column(
                            children: [
                              Gap(size.width * 0.4),
                              //Ticket-details
                              Container(
                                  width: size.width * 0.8,
                                  child: Column(
                                    children: [
                                      Text(
                                        _movieModun.name,
                                        style: TextStyle(
                                          fontWeight: bold,
                                          fontSize: 28,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Gap(8),
                                      Text(
                                        _movieModun.genre,
                                        style: TextStyle(
                                          fontWeight: medium,
                                          fontSize: 14,
                                          color: white.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  )),
                              Gap(32),
                              Container(
                                width: size.width * 0.8,
                                height: 1.5,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [yellow, Colors.transparent],
                                )),
                              ),
                              Gap(48),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            
            //Rating system
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '4.9',
                                //item.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: bold,
                                ),
                              ),
                              Text(
                                '/5',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: bold,
                                  color: white.withOpacity(0.8),
                                ),
                              ),
                              Gap(16),
                              Container(
                                width: 48,
                                child: Text(
                                  '182 Ratings',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: medium,
                                    color: white.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      RatingBar.builder(
                        unratedColor: white.withOpacity(0.2),
                        // Màu của sao khi chưa chọn
                        initialRating: _rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 32,
                        itemBuilder: (context, _) => FaIcon(FontAwesomeIcons.solidStar,
                          color: yellow,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                  Gap(24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * 0.7,
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Text here',
                            hintStyle: TextStyle(
                                color: white.withOpacity(0.6), fontWeight: light),
                            filled: true,
                            fillColor: white.withOpacity(0.1),
                            prefixIcon: IconButton(
                              icon: HeroIcon(HeroIcons.pencil, size: 14),
                              onPressed: () {
                                setState(() {
                                });
                              },
                            ),
                            prefixIconColor: white,
                          ),
                        ),
                      ),

                      Container(
                        child: GestureDetector(
                          onTap: () {
                            _submitReview();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RatingPage(
                                    movieID: widget.movieID),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: yellow,
                              shape: BoxShape.circle,
                            ),
                            child: HeroIcon(HeroIcons.arrowUp, size: 16, color: black,),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),

      ),
    );
  }

  // xử lý button submit reivew
  void _submitReview() {
    String reviewText = _textEditingController.text;
    _reivew_repository.addReview(
        _rating, reviewText, widget.userID, widget.movieID);
  }
}
