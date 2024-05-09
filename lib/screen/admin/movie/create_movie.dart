import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_1/repository/movie_repository.dart';
import 'package:project_1/screen/admin/movie/main_movie.dart';

import '../../../style/style.dart';
import '../../../test/test.dart';
import 'component.dart';

class CreateMovie extends StatefulWidget {
  const CreateMovie({super.key});

  @override
  State<CreateMovie> createState() => _CreateMovieState();
}

class _CreateMovieState extends State<CreateMovie> {
  //repository
  MovieRepository _repository = MovieRepository();

  //var
  final TextEditingController _age = TextEditingController();
  final TextEditingController _banner = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _director = TextEditingController();
  final TextEditingController _genre = TextEditingController();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _movieID = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _rating = TextEditingController();
  final TextEditingController _summary = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _trailer = TextEditingController();
  final String _urlLink = 'movie/image/' ;
  late TextEditingController _dateOutPut = TextEditingController();
  late DateTime _selectDate = DateTime.now();
  late String _formatDate = '00/00/0000';

  @override
  void initState() {
    super.initState();
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
        // title: Text('Name movie ${widget.number}'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //HEADING 1
              Text(
                'Movie',
                style: TextStyle(fontSize: 18, fontWeight: medium),
              ),
              Gap(16),
              //BODY 1

              InputItem(
                size: size,
                input: _name,
                hintText: 'name',
              ),
              InputItem(
                size: size,
                input: _age,
                hintText: 'age',
              ),
              // InputItem(size: size, input: _banner, hintText: 'banner',),
              // InputItem(size: size, input: _date, hintText: 'date',),
              InputItem(
                size: size,
                input: _director,
                hintText: 'director',
              ),
              InputItem(
                size: size,
                input: _genre,
                hintText: 'genre',
              ),
              // InputItem(size: size, input: _image, hintText: 'image',),

              InputItem(
                size: size,
                input: _rating,
                hintText: 'rating',
              ),
              InputItem(
                size: size,
                input: _summary,
                hintText: 'summary',
              ),
              InputItem(
                size: size,
                input: _time,
                hintText: 'time',
              ),

              // InputItem(size: size, input: _trailer, hintText: 'trailer',),
              Gap(24),
              DateInput(
                name: 'choose date',
                outPutDate: _dateOutPut,
                formatDate: _formatDate,
                selectDate: _selectDate,
              ),
              Gap(32),

              // UPLOAD FILE/FOLDER--------------------------------------
              // Text(
              //   'Heading',
              //   style: TextStyle(fontSize: 18, fontWeight: medium),
              // ),
              // Gap(16),
              //BODY 2
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         // Container(
              //         //   width: size.width / 2 + 16,
              //         //   margin: EdgeInsets.only(right: 8),
              //         //   child: TextFormField(
              //         //     //controller: ..,
              //         //     style: TextStyle(color: white),
              //         //     decoration: InputDecoration(
              //         //       border: OutlineInputBorder(
              //         //         borderSide: BorderSide.none,
              //         //         borderRadius: BorderRadius.circular(10),
              //         //       ),
              //         //       hintText: 'Search',
              //         //       hintStyle: TextStyle(
              //         //           color: white.withOpacity(0.6),
              //         //           fontWeight: light),
              //         //       filled: true,
              //         //       fillColor: white.withOpacity(0.1),
              //         //       prefixIconColor: white,
              //         //     ),
              //         //   ),
              //         // ),
              //         Gap(10),
              //         // Container(
              //         //   padding: EdgeInsets.all(16),
              //         //   decoration: BoxDecoration(
              //         //     color: yellow.withOpacity(0.2),
              //         //     borderRadius: BorderRadius.circular(50),
              //         //   ),
              //         //   child: HeroIcon(
              //         //     HeroIcons.plus,
              //         //     color: yellow,
              //         //   ),
              //         // ),
              //         Gap(10),
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Test(urlLink: _urlLink, urlOutPut: _image,),
              //               ),
              //             );
              //           },
              //           child: Container(
              //             padding: EdgeInsets.all(16),
              //             decoration: BoxDecoration(
              //               color: pink.withOpacity(0.2),
              //               borderRadius: BorderRadius.circular(50),
              //             ),
              //             child: HeroIcon(
              //               HeroIcons.arrowUp,
              //               color: pink,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

              Container(),

              Gap(24),

              //SAVE BUTTON
              GestureDetector(
                onTap: () {
                  setState(() {
                    _repository.createMovie(
                      name: _name.text,
                      image: _image.text,
                      banner: _banner.text,
                      age: _age.text,
                      summary: _summary.text,
                      date: _dateOutPut.text,
                      trailer: _trailer.text,
                      genre: _genre.text,
                      director: _director.text,
                      rating: 0,
                      time: _time.text,
                    );
                  });
                  // _createVoucher();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Main_Movie(),
                    ),
                  );
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'SAVE',
                    style:
                        TextStyle(fontSize: 16, color: black, fontWeight: bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputItem extends StatelessWidget {
  Size size;
  TextEditingController input;
  String hintText;

  InputItem(
      {required this.size,
      required this.input,
      required this.hintText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width,
      child: TextFormField(
        controller: input,
        style: TextStyle(color: white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          label: Text(hintText),
          hintStyle:
              TextStyle(color: white.withOpacity(0.6), fontWeight: light),
          filled: true,
          fillColor: white.withOpacity(0.1),
          prefixIconColor: white,
        ),
      ),
    );
  }
}
