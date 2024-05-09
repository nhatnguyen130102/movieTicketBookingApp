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
  @override
  void initState() {
    super.initState();
    // _latitude = widget.latitude;
    // _longitude = widget.longitude;
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
          // Center(
          //   child: Container(
          //     width: 300,
          //     height: 300,
          //     color: Colors.black,
          //     child: FutureBuilder(
          //       future: getCurrentLocation(),
          //       builder: (context, snapshot) {
          //         return Text(snapshot.data!.toString(),style: TextStyle(color: Colors.white),);
          //       },
          //     ),
          //   ),
          // ),
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
