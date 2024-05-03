import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:project_1/model/cinema_model.dart';
import 'package:project_1/repository/cinema_repository.dart';
import 'package:project_1/repository/location_repository.dart';
import 'package:project_1/screen/choosedate.dart';
import 'package:heroicons/heroicons.dart';

import '../component_widget/loading.dart';
import '../model/location_model.dart';
import '../style/style.dart';

class Choose_Location extends StatefulWidget {
  String movieID;

  Choose_Location({required this.movieID, super.key});

  @override
  State<Choose_Location> createState() => _Choose_LocationState();
}

class _Choose_LocationState extends State<Choose_Location> {
  //Repository zone
  CinemaRepository _cinemaRepository = CinemaRepository();
  LocationRepository _locationRepository = LocationRepository();

  //Variable zone
  late Future<List<CinemaModel>> _cinemas;
  late Future<List<LocationModel>> _location;
  late String _locationID = 'location1';
  late String _nameCinema = '';
  late String _cinemaBooked = '';
  // late Future<List<String>> _listCountCinema;
  // late List<String> _listStringCountCinema = [];
  // List<String> _cinemaNames = [];
  // List<String> _cinemaNumbers = [];

  late int _locationSelected = 0;
  late int _cinemaSelected = -1;
  late bool _locationBookedSelected = false;
  String todayFormat = DateFormat('dd/MM/yyyy').format(DateTime.now());



  @override
  void initState(){
    super.initState();
    _cinemas = _cinemaRepository.getCinemaByLocationID(_locationID);
    _location = _locationRepository.getAllLocations();
    // _listCountCinema = _cinemaRepository.countMovieByCinema(widget.movieID);

    // _listCountCinema.then((value) {
    //   setState(() {
    //     _listStringCountCinema.addAll(value);
    //   });
    // });
    // if(_listStringCountCinema.isNotEmpty){
    //   for(String item in _listStringCountCinema){
    //     List<String> parts = item.split('-');
    //     _cinemaNumbers.add(parts[1]);
    //     _cinemaNames.add(parts[0]);
    //   }
    // }
    // else{
    //   _cinemaNames.add('no Name');
    //   _cinemaNumbers.add('no Number');
    // }

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
      body: Stack(
        children: [
          // Column(
          //   children: _cinemaNames.map((e) => Text(e)).toList(),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: 40,
                  child: FutureBuilder(
                    future: _location,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Xử lý lỗi nếu có
                      } else if (snapshot.data == null) {
                        return Text(
                            'No data available'); // Xử lý khi không có dữ liệu
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(
                                      () {
                                    _locationSelected = index;
                                    _locationID =
                                        snapshot.data![index].locationID;
                                    _cinemas = _cinemaRepository.getCinemaByLocationID(_locationID);
                                    _cinemaSelected = -1;
                                  },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: 16,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _locationSelected == index
                                      ? Colors.yellow
                                      : Color(0xff1d2223),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data![index].name,
                                    style: TextStyle(
                                      color: _locationSelected == index
                                          ? black
                                          : Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      ;
                    },
                  ),
                ),
                Gap(30),
                Expanded(
                  child: FutureBuilder(
                    future: _cinemas,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Xử lý lỗi nếu có
                      } else if (snapshot.data == null) {
                        return Text(
                            'No data available'); // Xử lý khi không có dữ liệu
                      } else {

                        return Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              // int indexOf = _cinemaNames.indexOf('CGV Hùng Vương Plaza');
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _cinemaSelected = index;
                                    _nameCinema = snapshot.data![index].name;

                                    _cinemaBooked =
                                        snapshot.data![index].cinemaID;
                                    _locationBookedSelected = true;
                                  });
                                },
                                child: Container(
                                  height: 150,
                                  width: size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data![index].name ,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: semibold,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 8),
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _cinemaSelected == index
                                                  ? Colors.yellow
                                                  : white.withOpacity(0.3),
                                            ),
                                            child: HeroIcon(
                                              HeroIcons.check,
                                              color: black,
                                              size: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(4),
                                      Text(
                                        '1.8 km',
                                        style: TextStyle(color: white.withOpacity(0.8),),
                                      ),
                                      Gap(8),
                                      Row(
                                        children: [
                                          HeroIcon(
                                            HeroIcons.mapPin,
                                            color: white,
                                            size: 10,
                                          ),
                                          Gap(4),
                                          Expanded(
                                            child: Text(
                                              snapshot.data![index].address,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: white.withOpacity(0.6),
                                                fontSize: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Gap(32),
                                      Container(
                                        height: 1.5,
                                        width: size.width * 0.8,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              yellow, Colors.transparent,
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 10,
            right: 10,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: size.width,
                  height: 72,

                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 56,
                        decoration: BoxDecoration(
                          color: yellow,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Gap(20),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'CINEMA',
                                style: TextStyle(fontSize: 18, fontWeight: bold, color: yellow),
                              ),
                            ),
                            Gap(1),
                            Container(
                              child: Text(
                                _nameCinema != null ? _nameCinema : '',
                                // Kiểm tra _nameCinema, nếu null thì sử dụng chuỗi rỗng
                                style: TextStyle(fontWeight: medium),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  child:

                  //Cinema-Selection
                  GestureDetector(
                    onTap: _locationBookedSelected
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Choose_Date(
                              movieID: widget.movieID, cinemaID: _cinemaBooked, locationID:  _locationID,);
                        }),
                      );
                    } // Vô hiệu hóa GestureDetector nếu _locationBookedSelected là true
                        : null,

                    //Button-Next
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: _locationBookedSelected ? yellow : Colors
                                .grey),
                        child: Row(
                          children: [
                            Text('NEXT', style: TextStyle(color: black,
                                fontWeight: semibold,
                                fontSize: 18),),
                            Gap(8),
                            HeroIcon(HeroIcons.arrowRight),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
