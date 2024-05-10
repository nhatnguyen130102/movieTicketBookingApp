import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_1/repository/location_repository.dart';
import 'package:project_1/screen/admin/location/main_location.dart';

import '../../../model/location_model.dart';
import '../../../style/style.dart';
import '../component.dart';

class DetailLocation extends StatefulWidget {
  String locationID;

  DetailLocation({required this.locationID, super.key});

  @override
  State<DetailLocation> createState() => _DetailLocationState();
}

class _DetailLocationState extends State<DetailLocation> {
  //repo
  LocationRepository _locationRepository = LocationRepository();

  //var
  late TextEditingController _name = TextEditingController();
  late TextEditingController _ID = TextEditingController();

  late Future<LocationModel> _itemLocation;

  @override
  void initState() {
    super.initState();
    _itemLocation = _locationRepository.getLocationByID(widget.locationID);
    getLocation();
    setState(() {});
  }

  Future<void> getLocation() async {
    LocationModel? _modun = await _itemLocation;

    setState(() {
      _name.text = _modun!.name;
      _ID.text = _modun!.locationID;
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
                builder: (context) => MainLocation(),
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
                  'Location',
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
                  controller: _ID,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'locationID',
                    label: Text('locationID'),
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

              //BODY 2

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
                              'Bạn có muôn sửa khu vực?',
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
                                    _locationRepository.editLocation(
                                        locationID: widget.locationID,
                                        name: _name.text);
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainLocation(),
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
                              'Bạn có muôn tạo mới khu vực?',
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
                                    _locationRepository.createLocation(
                                        name: _name.text);
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainLocation(),
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
