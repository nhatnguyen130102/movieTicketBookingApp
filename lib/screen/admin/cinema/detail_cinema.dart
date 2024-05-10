import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_1/repository/location_repository.dart';
import 'package:project_1/screen/admin/cinema/main_cinema.dart';

import '../../../component_widget/loading.dart';
import '../../../model/cinema_model.dart';
import '../../../repository/cinema_repository.dart';
import '../../../style/style.dart';
import '../component.dart';

class DetailCinema extends StatefulWidget {
  String cinemaID;

  DetailCinema({required this.cinemaID, super.key});

  @override
  State<DetailCinema> createState() => _DetailCinemaState();
}

class _DetailCinemaState extends State<DetailCinema> {
  //repo
  CinemaRepository _cinemaRepository = CinemaRepository();
  LocationRepository _locationRepository = LocationRepository();

  //var
  late TextEditingController _name = TextEditingController();
  late TextEditingController _cinemaID = TextEditingController();
  late TextEditingController _locationID = TextEditingController();
  late TextEditingController _address = TextEditingController();
  late TextEditingController _longitude = TextEditingController();
  late TextEditingController _latitude = TextEditingController();

  late String _selectedFormat = 'Select ID';
  late List<String> _listFormatID = [];

  late Future<CinemaModel> _itemLocation;

  @override
  void initState() {
    super.initState();
    _itemLocation = _cinemaRepository.getCinemaByID(widget.cinemaID);
    getLocation();
    setState(() {});
  }

  Future<void> getLocation() async {
    CinemaModel? _modun = await _itemLocation;

    _name.text = _modun!.name;
    _longitude.text = _modun!.longitude.toString();
    _latitude.text = _modun!.latitude.toString();
    _address.text = _modun!.address;

    _selectedFormat = _modun.locationID;
    _cinemaID.text = widget.cinemaID;
    _listFormatID = await _cinemaRepository.getListLocation();
    setState(() {

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
                builder: (context) => MainCinema(),
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
                  'Cineme',
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
                  controller: _cinemaID,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'cinemaID',
                    label: Text('ciemaID'),
                    hintStyle: TextStyle(
                        color: white.withOpacity(0.6), fontWeight: light),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    prefixIconColor: white,
                  ),
                ),
              ),
              InputItem(
                input: _name,
                hintText: 'name',
              ),
              InputItem(
                input: _latitude,
                hintText: 'latitude',
              ),
              InputItem(
                input: _longitude,
                hintText: 'longitude',
              ),
              InputItem(
                input: _address,
                hintText: 'address',
              ),
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
                      future: _locationRepository.getLocationByID(value),
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
                              'Bạn có muôn sửa định dạng?',
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
                                    _cinemaRepository.editCinema(
                                        name: _name.text,
                                        address: _address.text,
                                        latitude: double.parse(_latitude.text),
                                        longitude:
                                            double.parse(_longitude.text),
                                        locationID: _selectedFormat,
                                        cinemaID: widget.cinemaID);
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainCinema(),
                                        ),
                                      );
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
                              'Bạn có muôn tạo định dạng mới?',
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
                                    _cinemaRepository.createCinema(
                                        name: _name.text,
                                        address: _address.text,
                                        latitude: double.parse(_latitude.text),
                                        longitude:
                                            double.parse(_longitude.text),
                                        locationID: _selectedFormat);
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainCinema(),
                                        ),
                                      );
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
