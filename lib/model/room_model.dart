import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  late String roomID;
  late String roomName;
  late String cinemaID; // ID của rạp chiếu phim
  late int quantitySeat; // Số lượng ghế
  late int row; // Số hàng

  RoomModel({
    required this.roomName,
    required this.roomID,
    required this.cinemaID,
    required this.quantitySeat,
    required this.row,
  });

  // Hàm factory để tạo một đối tượng RoomModel từ một Map
  factory RoomModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return RoomModel(
      roomName: data['roomName'],
      roomID: doc.id,
      cinemaID: data['cinemaID'],
      quantitySeat: data['quantitySeat'],
      row: data['row'],
    );
  }

  // Chuyển đổi RoomModel thành một Map
  Map<String, dynamic> toMap() {
    return {
      'roomName': roomName,
      'roomID': roomID,
      'cinemaID': cinemaID,
      'quantitySeat': quantitySeat,
      'row': row,
    };
  }
}
