import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:heroicons/heroicons.dart';
import 'package:latlong2/latlong.dart';


import '../../style/style.dart';

class ViewLocationPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  ViewLocationPage({required this.latitude, required this.longitude});

  @override
  _ViewLocationPageState createState() => _ViewLocationPageState();
}

class _ViewLocationPageState extends State<ViewLocationPage> {
  String locationMessage = 'Current Location of the User';
  late String lat;
  late String long;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permanetly denied,we cannot request.');
    }
    return await Geolocator.getCurrentPosition();
  }
  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      setState(() {
        locationMessage = 'Latitude: $lat , Longtitude: $long';
      });
    });
  }
  @override
  void initState() {
    super.initState();

    // _latitude = widget.latitude;
    // _longitude = widget.longitude;
    // turnon();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: white,
        leading: IconButton(
          icon: HeroIcon(HeroIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: FlutterMap(
              options: MapOptions(
                initialZoom: 18,
                initialCenter: LatLng(widget.latitude, widget.longitude),
                interactionOptions: const InteractionOptions(
                    flags: ~InteractiveFlag.doubleTapZoom),
              ),
              children: [
                openStreetMapTileLater,
                MarkerLayer(markers: [
                  Marker(
                    point: LatLng(widget.latitude, widget.longitude),
                    width: 60,
                    height: 60,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.location_pin,
                        size: 60,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 300,
              color: Colors.black,
              child:  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(locationMessage, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _getCurrentLocation().then((value) {
                          lat = '${value.latitude}';
                          long = '${value.longitude}';
                          setState(() {
                            locationMessage = 'Latitude: $lat , Longtitude: $long';
                          });
                          _liveLocation();
                        });
                      },
                      child: const Text('Get Current Location'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TileLayer get openStreetMapTileLater => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );

  Future<String> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String abc =
          'Latitude: ${position.latitude} - Longitude: ${position.longitude}';
      return abc;
    } catch (e) {
      return '';
    }
  }
}
