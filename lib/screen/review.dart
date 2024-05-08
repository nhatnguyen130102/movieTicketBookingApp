import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:project_1/screen/rating.dart';

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

  //var
  double _rating = 0;
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          foregroundColor: white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:



          Stack(
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
                          'https://th.bing.com/th/id/OIP.-IZCF5kfuY6ZX_VtxA8FPwFNC7?rs=1&pid=ImgDetMain',
                          fit: BoxFit.fill,
                        ),
                      ),
                      foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [black.withOpacity(0.5), black])),
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
                                'NHỮNG NGƯỜI BẠN TƯỞNG TƯỢNG',
                                style: TextStyle(
                                  fontWeight: bold,
                                  fontSize: 28,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Gap(8),
                              Text(
                                'Horror, Psychological, Family',
                                style: TextStyle(
                                  fontWeight: medium,
                                  fontSize: 10,
                                  color: white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          )),
                      Gap(24),
                      Container(
                        width: size.width * 0.8,
                        height: 1.5,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [yellow, yellow.withOpacity(0.5)],
                        )),
                      ),
                      Gap(24),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RatingBar.builder(
                              unratedColor: Colors.grey,
                              // Màu của sao khi chưa chọn
                              initialRating: _rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 40,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  _rating = rating;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _textEditingController,
                              decoration: InputDecoration(
                                hintText: 'Nhập đánh giá của bạn...',
                                hintStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  // Màu chữ của văn bản gợi ý
                                  fontStyle:
                                      FontStyle.italic, // Kiểu chữ in nghiêng
                                ),
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 5,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                _submitReview();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RatingPage(movieID: widget.movieID),
                                  ),
                                );
                              },
                              child: Text('Gửi đánh giá'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  // xử lý button submit reivew
  void _submitReview() {
    String reviewText = _textEditingController.text;
    _reivew_repository.addReview(_rating, reviewText, widget.userID, widget.movieID);
  }
}
