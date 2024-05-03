import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  late String locationID;
  late String name; // Tên của địa điểm

  LocationModel({
    required this.locationID,
    required this.name,
  });

  factory LocationModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return LocationModel(
      locationID: data['locationID'] ?? '',
      name: data['name'] ?? '',
    );
  }

  // Chuyển đổi LocationModel thành một Map
  Map<String, dynamic> toMap() {
    return {
      'locationID': locationID,
      'name': name,
    };
  }
}
