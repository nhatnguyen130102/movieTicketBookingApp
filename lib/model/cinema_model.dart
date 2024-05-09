import 'package:cloud_firestore/cloud_firestore.dart';

class CinemaModel {
  late String cinemaID; // ID của rạp chiếu phim
  late String locationID; // ID của địa điểm
  late String name; // Tên của rạp chiếu phim
  late String address;
  late List<Room> room; // Danh sách các phòng
  late double latitude;
  late double longitude;

  CinemaModel({
    required this.cinemaID,
    required this.locationID,
    required this.name,
    required this.room,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  // Hàm chuyển đổi dữ liệu từ Firestore thành một đối tượng Cinema
  factory CinemaModel.fromSnapshot(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return CinemaModel(
      cinemaID: data['cinemaID'] ?? '',
      locationID: data['locationID'] ?? '',
      name: data['name'] ?? '',
      address: data['address'],
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
      room: List<Room>.from(
        (data['room'] ?? []).map((room) => Room.fromMap(room)),
      ),
    );
  }
}

class Room {
  late String edge;
  late String formatID;
  late String name;

  Room({
    required this.name,
    required this.formatID,
    required this.edge,
  });

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      name: map['name'] ?? '',
      formatID: map['formatID'] ?? '',
      edge: map['edge'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'formatID': formatID,
      'edge': edge,
    };
  }
}
