
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../style/style.dart';

class ViewLocationPage extends StatefulWidget {
  // final double latitude;
  // final double longitude;

  //ViewLocationPage({required this.latitude, required this.longitude});

  @override
  _ViewLocationPageState createState() => _ViewLocationPageState();
}

class _ViewLocationPageState extends State<ViewLocationPage> {
  double latitude = 37.7749; // Example latitude
  double longitude = -122.4194; // Example longitude

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
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: FlutterMap(
          options: MapOptions(
            initialZoom: 18,
            initialCenter: LatLng(latitude, longitude),
            interactionOptions:
              const InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
          ),
          children: [
            openStreetMapTileLater,
            MarkerLayer(markers: [
              Marker(
                point: LatLng(latitude, longitude),
                width: 60,
                height: 60,
                child: GestureDetector(
                  onTap: (){},
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
    );
  }

  TileLayer get openStreetMapTileLater => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  );
}
