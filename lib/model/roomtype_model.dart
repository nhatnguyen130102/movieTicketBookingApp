import 'package:cloud_firestore/cloud_firestore.dart';

class RoomTypeModel {
  late String roomtypeID; // ID của loại phòng
  late String formatID; // ID của định dạng phim
  late String roomID; // ID của phòng chiếu

  RoomTypeModel({
    required this.roomtypeID,
    required this.formatID,
    required this.roomID,
  });

  // Hàm factory để tạo một đối tượng RoomTypeModel từ một Map
  factory RoomTypeModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return RoomTypeModel(
      roomtypeID: data['roomtypeID'],
      formatID: data['formatID'],
      roomID: data['roomID'],
    );
  }

  // Chuyển đổi RoomTypeModel thành một Map
  Map<String, dynamic> toMap() {
    return {
      'roomtypeID': roomtypeID,
      'formatID': formatID,
      'roomID': roomID,
    };
  }
}
