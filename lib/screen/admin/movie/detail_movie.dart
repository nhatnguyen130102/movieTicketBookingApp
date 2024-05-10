import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_1/model/movie_model.dart';
import 'package:project_1/screen/admin/screening/main_screenig.dart';

import '../../../repository/movie_repository.dart';
import '../../../style/style.dart';
import '../../../test/test.dart';
import '../component.dart';
import 'main_movie.dart';

class DetailMovie extends StatefulWidget {
  String movieID;

  DetailMovie({required this.movieID, super.key});

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  //repository
  MovieRepository _movieRepository = MovieRepository();

  //var
  final TextEditingController _age = TextEditingController();
  final TextEditingController _banner = TextEditingController();
  final TextEditingController _director = TextEditingController();
  final TextEditingController _genre = TextEditingController();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _summary = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _trailer = TextEditingController();
  final TextEditingController _actorName = TextEditingController();
  final TextEditingController _actorImamge = TextEditingController();
  late TextEditingController _dateOutPut = TextEditingController();

  final String _urlLinkImage = 'movie/image/';
  final String _urlLinkBanner = 'movie/banner/';
  final String _urlLinkActor = 'movie/actor/';
  late String _formatDate = '00/00/0000';
  late DateTime _selectDate = DateTime.now();

  late Future<MovieModel?> _itemMovie;
  late Future<List<Actor>> _itemActor;

  List<Widget> _listActorDisplay = [];
  late List<String> _listNameActor = [];
  late List<String> _listImgLink = [];
  late List<String> test = [];

  @override
  void initState() {
    super.initState();
    _itemMovie = _movieRepository.getMoviesByMovieID(widget.movieID);
    _itemActor = _movieRepository.getAllActorsForMovie(widget.movieID);
    getActor();
    getMovie();
    setState(() {});
  }

  Future<void> getMovie() async {
    MovieModel? _modun = await _itemMovie;
    _age.text = _modun!.age;
    _banner.text = _modun!.banner;
    _director.text = _modun!.director;
    _genre.text = _modun!.genre;
    _image.text = _modun!.image;
    _name.text = _modun!.name;
    _summary.text = _modun!.summary;
    _time.text = _modun!.time;
    _trailer.text = _modun!.trailer;
    _dateOutPut.text = _modun!.date;
    _formatDate = _modun!.date;
  }

  Future<void> getActor() async {
    var abc = await _itemActor;
    for (Actor item in abc) {
      _listNameActor.add(item.name);
      _listImgLink.add(item.image);
      _listActorDisplay.add(DisplayActor(actor: item.name, img: item.image));
    }
    setState(() {});
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
                builder: (context) => Main_Movie(),
              ),
            );
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
              Row(
                children: [
                  Container(
                    width: size.width * 0.5,
                    child: Text(
                      'Detail Movie',
                      style: TextStyle(fontSize: 18, fontWeight: medium),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MainScreening(movieID: widget.movieID),
                          ),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        color: yellow,
                        child: Center(
                          child: Text('all Screening',style: TextStyle(color: black),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Gap(16),
              //BODY 1
              InputItem(
                input: _name,
                hintText: 'name',
              ),
              InputItem(
                input: _age,
                hintText: 'age',
              ),
              InputItem(
                input: _director,
                hintText: 'director',
              ),
              InputItem(
                input: _genre,
                hintText: 'genre',
              ),

              InputItem(
                input: _summary,
                hintText: 'summary',
              ),
              InputItem(
                input: _time,
                hintText: 'time',
              ),
              InputItem(
                input: _trailer,
                hintText: 'trailerUrl',
              ),
              Gap(20),
              Text(
                'List Actor',
                style: TextStyle(fontSize: 18, fontWeight: medium),
              ),

              Row(
                children: [
                  Column(children: _listActorDisplay.map((e) => e).toList()),
                  Column(
                      children: _listActorDisplay
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _deleteActor(_listActorDisplay.indexOf(e));
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 30),
                                padding: EdgeInsets.only(top: 30),
                                width: size.width * 0.2,
                                height: size.width * 0.2,
                                child: Text('delete' +
                                    _listActorDisplay.indexOf(e).toString()),
                              ),
                            ),
                          )
                          .toList()),
                ],
              ),

              Gap(20),
              Row(
                children: [
                  InputActor(
                    urlLinkImage: _urlLinkActor,
                    imgOutPut: _actorImamge,
                    input: _actorName,
                    hintText: 'actor name',
                  ),
                  Gap(10),
                  GestureDetector(
                    onTap: _addActor,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: yellow.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: HeroIcon(
                        HeroIcons.plus,
                        color: yellow,
                      ),
                    ),
                  ),
                ],
              ),

              Gap(16),
              //BODY 2
              Gap(24),
              DateInput(
                name: 'choose date',
                outPutDate: _dateOutPut,
                formatDate: _formatDate,
                selectDate: _selectDate,
              ),
              Gap(32),

              Row(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: _image.text != ''
                        ? Image.network(_image.text)
                        : Image.network(
                            'https://cdn.icon-icons.com/icons2/2248/PNG/512/null_icon_135358.png'),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Test(
                                urlLink: _urlLinkImage,
                                urlOutPut: _image,
                              ),
                            ),
                          );
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: pink.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: HeroIcon(
                          HeroIcons.arrowUp,
                          color: pink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(10),
              Row(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: _banner.text != ''
                        ? Image.network(_banner.text)
                        : Image.network(
                            'https://cdn.icon-icons.com/icons2/2248/PNG/512/null_icon_135358.png'),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Test(
                                urlLink: _urlLinkBanner,
                                urlOutPut: _banner,
                              ),
                            ),
                          );
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: pink.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: HeroIcon(
                          HeroIcons.arrowUp,
                          color: pink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(24),

              //SAVE BUTTON
              GestureDetector(
                onTap: () {
                  setState(() {
                    _movieRepository.editMovie(
                      actorName: _listNameActor,
                      actorImage: _listImgLink,
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
                      movieID: widget.movieID,
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

  Future<void> _deleteActor(int index) async {
    await _listActorDisplay.removeAt(index);
    await _listImgLink.removeAt(index);
    await _listNameActor.removeAt(index);
  }

  void _addActor() {
    setState(() {
      InputActor(
        urlLinkImage: _urlLinkActor,
        imgOutPut: _actorImamge,
        input: _actorName,
        hintText: 'actor name',
      );
      _listNameActor.add(_actorName.text);
      _listImgLink.add(_actorImamge.text);
      _listActorDisplay.add(DisplayActor(
        actor: _actorName.text,
        img: _actorImamge.text,
      ));
    });
  }
}
