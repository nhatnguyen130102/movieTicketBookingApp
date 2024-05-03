import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:project_1/model/screening_model.dart';

class Screening_Repository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Timer _timer;

// lấy ra danh sách screening theo movieID
  Future<List<ScreeningModel>> getScreeningByMovieID(String movieID) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('screening')
          .where('movieID', isEqualTo: movieID)
          .get();
      return querySnapshot.docs.map((e) => ScreeningModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ScreeningModel>> getScreeningByMovieIDDateCinemaID(
      String movieID, String date, String cinemaID) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('screening')
          .where('movieID', isEqualTo: movieID)
          .where('date', isEqualTo: date)
          .where('cinemaID', isEqualTo: cinemaID)
          .get();
      return querySnapshot.docs.map((e) => ScreeningModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  void addBookedScreening(String screeningID, List<String> booked) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('screening')
          .where('screeningID', isEqualTo: screeningID)
          .get();
      ScreeningModel _itemScreening =
          querySnapshot.docs.map((e) => ScreeningModel.fromMap(e)).first;
      for (String item in _itemScreening.booked) {
        booked.add(item);
      }
      await _firestore
          .collection('screening')
          .doc(
              screeningID) // Sử dụng doc() để tham chiếu đến tài liệu có screeningID tương ứng
          .set(
            {
              'booked': booked,
            },
            SetOptions(
                merge:
                    true), // Sử dụng merge: true để cập nhật trường booked mà không ghi đè các trường khác
          )
          .then((value) => print('Document added/updated successfully'))
          .catchError(
              (error) => print('Failed to add/update document: $error'));
    } catch (e) {
      print('Error: $e');
    }
  }






  Future<List<String>> getBookedSeats(String screeningId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('screening').doc(screeningId).get();

      if (documentSnapshot.exists) {
        // Xác định kiểu của dữ liệu trong documentSnapshot.data()
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        // Kiểm tra xem dữ liệu có null hay không
        if (data != null) {
          // Truy cập trường 'booked' từ dữ liệu và chuyển đổi sang List<String>
          List<String>? bookedSeats = List<String>.from(data['booked'] ?? []);

          // Trả về danh sách ghế đã đặt
          return bookedSeats ?? [];
        } else {
          // Trả về danh sách rỗng nếu dữ liệu là null
          return [];
        }
      } else {
        // Trả về danh sách rỗng nếu không tìm thấy document
        return [];
      }
    } catch (e) {
      // Xử lý lỗi và trả về danh sách rỗng
      print('Error retrieving booked seats: $e');
      return [];
    }
  }

  Future<ScreeningModel?> getScreeningByID(String screeningID) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('screening')
          .where('screeningID', isEqualTo: screeningID)
          .get();
      return querySnapshot.docs.map((e) => ScreeningModel.fromMap(e)).first;
    } catch (e) {
      return null;
    }
  }


}
