import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:project_1/model/booking_model.dart';
import 'package:project_1/model/screening_model.dart';
import 'package:project_1/model/user_model.dart';
import 'package:project_1/style/style.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBookingUser(String bookingID,String userID, String movieID, String cinemaID, String screeningID, double subtotal, double total, String voucherID, List<String> seat) async{
    try {
      Map<String, dynamic> bookingData = {
        'bookingID': bookingID,
        'cinemaID': cinemaID,
        'movieID': movieID,
        'screeningID': screeningID,
        'seat': seat,
        'subtotal': subtotal,
        'total': total,
        'voucherID': voucherID,
      };
      await _firestore.collection('user').doc(userID).collection('booking').doc(bookingID).set(bookingData);
    }
    catch (e){
      throw e;
    }
  }

  Future<List<BookingItem>?> historyTicket(String userID) async{
    try {
      CollectionReference bookingCollectionRef =  await _firestore.collection('user').doc(userID).collection('booking');
      QuerySnapshot querySnapshot = await bookingCollectionRef.get();
      List<BookingItem> bookings = querySnapshot.docs.map((e) => BookingItem.fromMap(e)).toList();
      return bookings;
    }
    catch (e)
    {
      return null;
    }
  }
  Future<BookingItem?> getBookingUser(String bookingID, String userID) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('user')
          .doc(userID)
          .collection('booking')
          .where('bookingID', isEqualTo: bookingID)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Lấy phần tử đầu tiên từ danh sách kết quả
        QueryDocumentSnapshot bookingDocument = querySnapshot.docs.first;
        // Chuyển đổi từ dữ liệu của document sang BookingItem
        BookingItem _booked = BookingItem.fromMap(bookingDocument);
        return _booked;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
