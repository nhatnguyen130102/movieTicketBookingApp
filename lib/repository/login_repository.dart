import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/login_model.dart';

class UserRepository {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user');

  // Phương thức để thêm người dùng mới vào Firestore
  Future<void> addUser(UserModel user) async {
    try {
      await usersCollection.add(user.toMap());
    } catch (e) {
      print('Failed to add user: $e');
    }
  }

  // Phương thức để cập nhật thông tin người dùng trong Firestore
  Future<void> updateUser(UserModel user) async {
    try {
      await usersCollection.doc(user.userID).update(user.toMap());
    } catch (e) {
      print('Failed to update user: $e');
    }
  }

  // Phương thức để xóa người dùng khỏi Firestore
  Future<void> deleteUser(String userID) async {
    try {
      await usersCollection.doc(userID).delete();
    } catch (e) {
      print('Failed to delete user: $e');
    }
  }

  // Phương thức để lấy thông tin của một người dùng từ Firestore dựa trên userID
  Future<UserModel?> getUser(String userID) async {
    try {
      DocumentSnapshot snapshot = await usersCollection.doc(userID).get();
      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data() as DocumentSnapshot<Object?>);
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to get user: $e');
      return null;
    }
  }

  // Phương thức để lấy thông tin của một người dùng từ Firestore dựa trên username

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserByUsername(String username) async {
    try {
      var userSnapshot = await _firestore
          .collection('user')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        var userData = userSnapshot.docs.first.data();
        return UserModel.fromMap(userData as DocumentSnapshot<Object?>);
      } else {
        return null; // Trả về null nếu không tìm thấy người dùng
      }
    } catch (e) {
      print('Error fetching user by username: $e');
      return null;
    }
  }

  // Phương thức để lấy danh sách tất cả người dùng từ Firestore
  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await usersCollection.get();
      List<UserModel> userList = [];
      querySnapshot.docs.forEach((doc) {
        userList
            .add(UserModel.fromMap(doc.data() as DocumentSnapshot<Object?>));
      });
      return userList;
    } catch (e) {
      print('Failed to get all users: $e');
      return [];
    }
  }
}
