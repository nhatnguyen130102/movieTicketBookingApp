import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_1/model/movie_model.dart';
import 'package:project_1/repository/movie_repository.dart';

import '../../../component_widget/loading.dart';
import '../../../style/style.dart';
import '../AD_sidebar.dart';
import 'create_movie.dart';
import 'detail_movie.dart';

class Main_Movie extends StatefulWidget {
  const Main_Movie({super.key});

  @override
  State<Main_Movie> createState() => _Main_MovieState();
}

class _Main_MovieState extends State<Main_Movie> {
  // repo
  MovieRepository _movieRepository = MovieRepository();

  //var
  late Future<List<MovieModel>> _listMovie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listMovie = _movieRepository.getMovies();
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
        child: Container(
          height: size.height,
          width: size.width,
          child: FutureBuilder(
            future: _listMovie,
            builder: (context, SnapShot) {
              if (SnapShot.connectionState == ConnectionState.waiting) {
                return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
              } else if (SnapShot.hasError) {
                return Text('Error: ${SnapShot.error}'); // Xử lý lỗi nếu có
              } else if (SnapShot.data == null) {
                return Text('No data available'); // Xử lý khi không có dữ liệu
              } else {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: SnapShot.data!.length,
                  itemBuilder: (context, index) {
                    MovieModel _modun = SnapShot.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailMovie(movieID: _modun.movieID),
                          ),
                        );
                      },
                      //Item
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
                              width: size.width * 0.24,
                              height: size.width * 0.32,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _modun.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
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
                                      fontSize: 18,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  Gap(4),
                                  Text(
                                    _modun.genre,
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
                                        width: size.width * 0.2,
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
                                                  _modun.rating
                                                      .toStringAsFixed(1),
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
                                                  _modun.time,
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
                                                  _modun.age,
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

                                      // Gap(10),
                                      // //Edit Button
                                      // Container(
                                      //   padding: EdgeInsets.symmetric(
                                      //       vertical: 12, horizontal: 16),
                                      //   decoration: BoxDecoration(
                                      //     color: yellow,
                                      //     borderRadius:
                                      //         BorderRadius.circular(5),
                                      //   ),
                                      //   child: Text('EDIT',
                                      //       style: TextStyle(
                                      //         fontSize: 12,
                                      //         fontWeight: bold,
                                      //         color: black,
                                      //       )),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // child: Container(
                      //   margin: EdgeInsets.symmetric(
                      //     vertical: 10,
                      //   ),
                      //   height: 150,
                      //   width: size.width,
                      //   color: yellow,
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: size.width * 1 / 3,
                      //         margin: EdgeInsets.symmetric(
                      //           horizontal: 10,
                      //         ),
                      //         child: CircleAvatar(
                      //           radius: 50, // Đặt bán kính của avatar
                      //           backgroundImage: NetworkImage(_userModun
                      //               .photoURL), // Đặt hình ảnh nền của avatar
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //               child: Text(
                      //                 _userModun.email,
                      //                 style: TextStyle(
                      //                   color: black,
                      //                   fontSize: 15,
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //               child: Text(
                      //                 _userModun.username,
                      //                 style: TextStyle(
                      //                   color: black,
                      //                   fontSize: 15,
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateMovie()),
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
