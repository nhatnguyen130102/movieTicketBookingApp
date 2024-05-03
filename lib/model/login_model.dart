import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String userID;
  late String username;
  late String password;
  late String role;
  late bool status;

  UserModel({
    required this.userID,
    required this.username,
    required this.password,
    required this.role,
    required this.status,
  });

  // Phương thức từMap để tạo đối tượng User từ dữ liệu trả về từ Firestore
  factory UserModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserModel(
      userID: doc.id,
      username: data['username'] ?? '',
      password: data['password'] ?? '',
      role: data['role'] ?? '',
      status: data['status'] ?? true,
    );
  }

  // Phương thức toMap để chuyển đổi đối tượng User thành một Map để lưu vào Firestore
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'username': username,
      'password': password,
      'role': role,
      'status': status,
    };
  }

  factory UserModel.fromJson(String json) {
    return UserModel.fromMap(jsonDecode(json));
  }
}
