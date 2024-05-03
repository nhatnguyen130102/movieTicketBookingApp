

import 'package:cloud_firestore/cloud_firestore.dart';

class FormatModel {
  late String formatID; // ID của định dạng phim
  late String name; // Tên của định dạng phim

  FormatModel({
    required this.formatID,
    required this.name,
  });

  factory FormatModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return FormatModel(
      formatID: data['formatID'] ?? '',
      name: data['name'] ?? '',
    );
  }

  // Chuyển đổi FormatModel thành một Map
  Map<String, dynamic> toMap() {
    return {
      'formatID': formatID,
      'name': name,
    };
  }
}
