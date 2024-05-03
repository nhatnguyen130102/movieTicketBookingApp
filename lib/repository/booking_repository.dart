import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:project_1/model/booking_model.dart';
import 'package:project_1/model/screening_model.dart';
import 'package:project_1/style/style.dart';

class BookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBooking(String screengID, String userID, List<String> seat,
      double total, double subtotal, String cinemaID, String voucherID, String bookingID) async {
    try {
      QuerySnapshot _getScreening = await _firestore
          .collection('screening')
          .where('screeningID', isEqualTo: screengID)
          .get();
      ScreeningModel? _itemScreening =
          _getScreening.docs.map((e) => ScreeningModel.fromMap(e)).first;
      DateTime _today = DateTime.now();
      DateFormat getDateTime = DateFormat('dd/MM/yyyy');
      String todayFormat = DateFormat('dd/MM/yyyy').format(DateTime.now());
      String todayFormatID = DateFormat('ddMMyyyy').format(DateTime.now());

      Map<String, dynamic> bookingData = {
        'bookingID': bookingID,
        'cinemaID': cinemaID,
        'dateBooking': todayFormat,
        'movieID': _itemScreening.movieID,
        'screeningID': _itemScreening.screeningID,
        'seat': seat,
        'subtotal': subtotal,
        'total': total,
        'userID': userID,
        'voucherID': voucherID,
      };

      await _firestore.collection('booking').doc(bookingID).set(bookingData);
    } catch (e) {
      throw e;
    }
  }
}
