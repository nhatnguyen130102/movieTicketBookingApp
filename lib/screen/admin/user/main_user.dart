import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_1/repository/user_repository.dart';
import '../../../component_widget/loading.dart';
import '../../../model/user_model.dart';
import '../../../style/style.dart';

class Main_User extends StatefulWidget {
  const Main_User({super.key});

  @override
  State<Main_User> createState() => _Main_UserState();
}

class _Main_UserState extends State<Main_User> {
  // repo
  UserRepository _userRepository = UserRepository();

  //var
  late Future<List<UserModel>> _listUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listUser = _userRepository.getAllUsers();
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
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: FutureBuilder(
            future: _listUser,
            builder: (context, userSnapShot) {
              if (userSnapShot.connectionState == ConnectionState.waiting) {
                return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
              } else if (userSnapShot.hasError) {
                return Text('Error: ${userSnapShot.error}'); // Xử lý lỗi nếu có
              } else if (userSnapShot.data == null) {
                return Text('No data available'); // Xử lý khi không có dữ liệu
              } else {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: userSnapShot.data!.length,
                  itemBuilder: (context, index) {
                    UserModel _userModun = userSnapShot.data![index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Detail_User(),
                        //   ),
                        // );
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
                                  _userModun.photoURL,
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
                                    'ABC',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  Gap(4),

                                  Text(
                                    'abc',
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            //Quick Info
                                            Row(
                                              children: [
                                                Icon(Icons.star, color: yellow, size: 14),
                                                Gap(8),
                                                Text(
                                                  'abc',
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
                                                Icon(Icons.star, color: yellow, size: 14),
                                                Gap(8),
                                                Text(
                                                  'abc',
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
                                                Icon(Icons.star, color: yellow, size: 14),
                                                Gap(8),
                                                Text(
                                                  'abc',
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

                                      Gap(10),
                                      //Edit Button
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: yellow,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Text('EDIT',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: bold,
                                              color: black,
                                            )
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
    );
  }
}
