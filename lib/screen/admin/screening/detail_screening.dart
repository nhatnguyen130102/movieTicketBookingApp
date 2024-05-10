import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:project_1/model/screening_model.dart';
import 'package:project_1/repository/cinema_repository.dart';
import 'package:project_1/repository/format_repository.dart';
import 'package:project_1/repository/screening_repository.dart';

import '../../../component_widget/loading.dart';
import '../../../style/style.dart';
import '../component.dart';
import 'main_screenig.dart';

class DetailScreening extends StatefulWidget {
  String screeningID;
  String movieID;

  DetailScreening(
      {required this.movieID, required this.screeningID, super.key});

  @override
  State<DetailScreening> createState() => _DetailScreeningState();
}

class _DetailScreeningState extends State<DetailScreening> {
  //repo
  Screening_Repository _screening_repository = Screening_Repository();
  FormatRepository _formatRepository = FormatRepository();
  CinemaRepository _cinemaRepository = CinemaRepository();

//var

  final TextEditingController _time = TextEditingController();
  final TextEditingController _room = TextEditingController();
  final TextEditingController _movieID = TextEditingController();
  late TextEditingController _dateOutPut = TextEditingController();
  late DateTime _selectDate = DateTime.now();
  late String _formatDate = '00/00/0000';
  late Future<ScreeningModel?> _itemScreening;
  late List<String> _listCinemaID = [];
  late List<String> _listFormatID = [];

  late String _selectedItem = 'Select ID'; // Biến để lưu trữ mục được chọn
  late String _selectedFormat = 'Select ID';

  @override
  void initState() {
    super.initState();
    _itemScreening = _screening_repository.getScreeningByID(widget.screeningID);
    getScreening();
    setState(() {});
  }

  Future<void> getScreening() async {
    ScreeningModel? _modun = await _itemScreening;
    _dateOutPut.text = _modun!.date;
    _formatDate = _modun!.date;
    _time.text = _modun!.time;
    _room.text = _modun!.room;
    _movieID.text = widget.movieID;
    final DateFormat format = DateFormat('dd/MM/yyyy');
    _listCinemaID = await _screening_repository.getListCinemaID();
    _selectedItem = _modun.cinemaID;
    _listFormatID = await _screening_repository.getListFormatID();
    _selectedFormat = _modun.formatID;
    setState(() {
      _selectDate = format.parse(_modun!.date);
    });
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
                builder: (context) => MainScreening(movieID: widget.movieID),
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
              Container(
                width: size.width * 0.5,
                child: Text(
                  'Screening',
                  style: TextStyle(fontSize: 18, fontWeight: medium),
                ),
              ),

              Gap(16),
              //BODY 1
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width,
                child: TextFormField(
                  readOnly: true,
                  controller: _movieID,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'movieID',
                    label: Text('movieID'),
                    hintStyle: TextStyle(
                        color: white.withOpacity(0.6), fontWeight: light),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    prefixIconColor: white,
                  ),
                ),
              ),
              InputItem(
                input: _time,
                hintText: 'time',
              ),
              InputItem(
                input: _room,
                hintText: 'room',
              ),
              Gap(10),
              DropdownButton<String>(
                value: _selectedItem,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _selectedItem = value!;
                  });
                },
                items:
                    _listCinemaID.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: FutureBuilder(
                      future: _cinemaRepository.getCinemaByID(value),
                      builder: (context, nameMovie) {
                        if (nameMovie.connectionState ==
                            ConnectionState.waiting) {
                          return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                        } else if (nameMovie.hasError) {
                          return Text(
                              'Error: ${nameMovie.error}'); // Xử lý lỗi nếu có
                        } else if (nameMovie.data == null) {
                          return Text(
                              'No data available'); // Xử lý khi không có dữ liệu
                        } else {
                          return Text(nameMovie.data!.name);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
              Gap(20),
              DropdownButton<String>(
                value: _selectedFormat,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _selectedFormat = value!;
                  });
                },
                items:
                    _listFormatID.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: FutureBuilder(
                      future: _formatRepository.getFormatByID(value),
                      builder: (context, nameMovie) {
                        if (nameMovie.connectionState ==
                            ConnectionState.waiting) {
                          return Loading(); // Hiển thị loading indicator nếu đang chờ dữ liệu
                        } else if (nameMovie.hasError) {
                          return Text(
                              'Error: ${nameMovie.error}'); // Xử lý lỗi nếu có
                        } else if (nameMovie.data == null) {
                          return Text(
                              'No data available'); // Xử lý khi không có dữ liệu
                        } else {
                          return Text(nameMovie.data!.name);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
              //BODY 2
              Gap(24),
              DateInput(
                name: 'choose date',
                outPutDate: _dateOutPut,
                formatDate: _formatDate,
                selectDate: _selectDate,
              ),
              Gap(32),
              //SAVE BUTTON
              GestureDetector(
                onTap: () {
                  setState(() {

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              'Thông báo',
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          content: Container(
                            width: size.width * 0.7,
                            height: 40,
                            child: Text(
                              'Bạn có muôn sửa suất chiếu?',
                              style: TextStyle(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.redAccent,
                                    ),
                                    height: 50,
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        'Cancle',
                                        style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _screening_repository.editScreening(
                                      screeningID: widget.screeningID,
                                      time: _time.text,
                                      movieID: widget.movieID,
                                      cinemaID: _selectedItem,
                                      date: _dateOutPut.text,
                                      formatID: _selectedFormat,
                                      room: _room.text,
                                    );
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreening(movieID: widget.movieID),),);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.redAccent,
                                    ),
                                    height: 50,
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  });
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'EDIT',
                    style:
                        TextStyle(fontSize: 16, color: black, fontWeight: bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Gap(10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              'Thông báo',
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          content: Container(
                            width: size.width * 0.7,
                            height: 40,
                            child: Text(
                              'Bạn có muôn tạo mới suất chiếu?',
                              style: TextStyle(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.redAccent,
                                    ),
                                    height: 50,
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        'Cancle',
                                        style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _screening_repository.creatScreening(
                                      screeningID: widget.screeningID,
                                      time: _time.text,
                                      movieID: widget.movieID,
                                      cinemaID: _selectedItem,
                                      date: _dateOutPut.text,
                                      formatID: _selectedFormat,
                                      room: _room.text,
                                    );
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreening(movieID: widget.movieID),),);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.redAccent,
                                    ),
                                    height: 50,
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  });
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'CREATE',
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
