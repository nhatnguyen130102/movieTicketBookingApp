import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_1/repository/movie_repository.dart';
import 'package:project_1/repository/user_repository.dart';
import 'package:project_1/screen/review.dart';

import '../component_widget/loading.dart';
import '../model/movie_model.dart';
import '../repository/reivew_repository.dart';
import '../style/style.dart';

class RatingPage extends StatefulWidget {
  String movieID;

  RatingPage({required this.movieID, super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  //repo
  Review_Repository _reivew_repository = Review_Repository();
  MovieRepository _movieRepository = MovieRepository();
  UserRepository _userRepository = UserRepository();

  //var
  late Future<List<UserRating>> _listRating;
  late Future<bool> isRating;
  late bool isRatingFormat;
  late Future<MovieModel?> _item;
  double _rating = 0;
  TextEditingController _textEditingController = TextEditingController();
  final int maxLength = 220;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userID;
  late bool isLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfUserIsLoggedIn();
    isRating = _reivew_repository.checkReview(widget.movieID, userID);
    _item = _movieRepository.getMoviesByMovieID(widget.movieID);
    _listRating = _reivew_repository.allRating(widget.movieID);
  }

  void _checkIfUserIsLoggedIn() async {
    // Kiểm tra xem có người dùng nào đã đăng nhập trước đó hay không
    User? user = _auth.currentUser;
    if (user != null) {
      userID = FirebaseAuth.instance.currentUser!.uid!;
      isLogin = true;
    } else {
      userID = '';
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
        future: _item,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Xử lý lỗi nếu có
          } else if (snapshot.data == null) {
            return Text('No data available'); // Xử lý khi không có dữ liệu
          } else {
            MovieModel item = snapshot.data!;
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //Header--------
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: 120 * 1.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Gap(24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    item.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: yellow,
                                      fontSize: 20,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ),
                                Gap(2),
                                Container(
                                  child: Text(
                                    item.genre,
                                    style: TextStyle(
                                      color: white.withOpacity(0.8),
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
                                            item.time,
                                            style: TextStyle(
                                              fontWeight: medium,
                                              fontSize: 14,
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
                                          Gap(8),
                                          Text(
                                            item.age,
                                            style: TextStyle(
                                              fontWeight: medium,
                                              fontSize: 14,
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
                        ],
                      ),
                    ),
                    Gap(24),

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
                              ],
                            ),
                            Gap(2),
                            Text(
                              '182 Ratings',
                              style: TextStyle(
                                fontSize: 11,
                                color: white.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(10),
                    FutureBuilder(
                      future: _reivew_repository.checkReview(
                          userID, widget.movieID),
                      builder: (context, checkSnapShot) {
                        if (checkSnapShot.connectionState ==
                            ConnectionState.waiting) {
                          return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                        } else if (checkSnapShot.hasError) {
                          return Text(
                              'Error: ${checkSnapShot.error}'); // Xử lý lỗi nếu có
                        } else if (checkSnapShot.data == null) {
                          return Text(
                              'No data available'); // Xử lý khi không có dữ liệu
                        } else {
                          isRatingFormat = checkSnapShot.data!;
                          return GestureDetector(
                            onTap: isLogin
                                ? isRatingFormat
                                    ? null
                                    : () {
                                        // Hiển thị hộp thoại khi nhấn vào nút
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReviewPage(
                                              movieID: widget.movieID,
                                              userID: userID,
                                            ),
                                          ),
                                        );
                                      }
                                : null,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              padding: EdgeInsets.all(5),
                              height: 50,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              child: isLogin
                                  ? isRatingFormat
                                      ? Text(
                                          'Ban da danh gia roi',
                                          style: TextStyle(color: white),
                                        )
                                      : Text(
                                          'Review',
                                          style: TextStyle(color: white),
                                        )
                                  : Text(
                                      'Ban can dang nhap va dat ve de co the danh gia',
                                    ),
                            ),
                          );
                        }
                      },
                    ),

                    Gap(10),

                    //Comment-Item
                    FutureBuilder(
                      future: _listRating,
                      builder: (context, ratingSnapShot) {
                        if (ratingSnapShot.connectionState ==
                            ConnectionState.waiting) {
                          return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                        } else if (ratingSnapShot.hasError) {
                          return Text(
                              'Error: ${ratingSnapShot.error}'); // Xử lý lỗi nếu có
                        } else if (ratingSnapShot.data == null) {
                          return Text(
                              'No data available'); // Xử lý khi không có dữ liệu
                        } else {
                          return Container(
                            width: size.width,
                            height: 400,
                            child: ListView.builder(
                              itemCount: ratingSnapShot.data!.length,
                              itemBuilder: (context, index) {
                                UserRating _userRatingModun =
                                    ratingSnapShot.data![index];
                                return FutureBuilder(
                                  future: _userRepository
                                      .getUserByID(_userRatingModun.userID),
                                  builder: (context, userSnapShot) {
                                    if (userSnapShot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                                    } else if (userSnapShot.hasError) {
                                      return Text(
                                          'Error: ${userSnapShot.error}'); // Xử lý lỗi nếu có
                                    } else if (userSnapShot.data == null) {
                                      return Text(
                                          'No data available'); // Xử lý khi không có dữ liệu
                                    } else {
                                      return Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 16),
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: white.withOpacity(0.08),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                //User-info
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Image.network(
                                                          userSnapShot
                                                              .data!.photoURL,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Gap(8),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          userSnapShot
                                                              .data!.username,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                semibold,
                                                          ),
                                                        ),
                                                        Gap(4),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.star,
                                                                color: yellow,
                                                                size: 14),
                                                            Gap(4),
                                                            Text(
                                                              _userRatingModun
                                                                  .ratingStar
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    medium,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                HeroIcon(
                                                  HeroIcons.ellipsisVertical,
                                                  color: white.withOpacity(0.7),
                                                ),
                                              ],
                                            ),
                                            Gap(16),

                                            //Comment
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                ExpandableText(
                                                  _userRatingModun.review,
                                                  style: TextStyle(
                                                      color: white
                                                          .withOpacity(0.8),
                                                      fontSize: 12),
                                                  expandText: 'show more',
                                                  collapseText: 'show less',
                                                  maxLines: 3,
                                                  linkColor: yellow,
                                                  linkStyle: TextStyle(
                                                    fontWeight: bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Gap(16),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: white
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            HeroIcon(
                                                              HeroIcons.heart,
                                                              size: 12,
                                                              color: white
                                                                  .withOpacity(
                                                                      0.6),
                                                            ),
                                                            Gap(4),
                                                            Text(
                                                              _userRatingModun
                                                                  .like
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: white
                                                                    .withOpacity(
                                                                        0.6),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Gap(8),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: white
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            HeroIcon(
                                                              HeroIcons
                                                                  .chatBubbleOvalLeft,
                                                              size: 14,
                                                              color: white
                                                                  .withOpacity(
                                                                      0.6),
                                                            ),
                                                            Gap(4),
                                                            Text(
                                                              _userRatingModun
                                                                  .reply.length
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: white
                                                                    .withOpacity(
                                                                        0.6),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  _userRatingModun.date,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        white.withOpacity(0.5),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
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
                    //Comment-Item
                    //Comment-Item
                  ],
                ),
              ),
            );
          }
          ;
        },
      ),
    );
  }

  void _submitReview() {
    // Lưu đánh giá của người dùng vào cơ sở dữ liệu hoặc thực hiện hành động phù hợp ở đây
    String reviewText = _textEditingController.text;
    // Đánh giá từ người dùng có thể lưu hoặc gửi đi ở đây
    print('Rating: $_rating, Review: $reviewText');
  }
}
