import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  late String bookingID;
  late String cinemaID;
  late String dateBooking;
  late String movieID;
  late String screeningID;
  late List<String> seat;
  late double subtotal;
  late double total;
  late String userID;
  late String voucherID;

  BookingModel({
    required this.bookingID,
    required this.cinemaID,
    required this.dateBooking,
    required this.movieID,
    required this.screeningID,
    required this.seat,
    required this.subtotal,
    required this.total,
    required this.userID,
    required this.voucherID,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookingID': bookingID,
      'cinemaID': cinemaID,
      'dateBooking': dateBooking,
      'movieID': movieID,
      'screeningID': screeningID,
      'seat': seat,
      'subtotal': subtotal,
      'total': total,
      'userID': userID,
      'voucherID': voucherID,
    };
  }

  factory BookingModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      bookingID: data['bookingID'],
      cinemaID: data['cinemaID'],
      dateBooking: data['dateBooking'],
      movieID: data['movieID'],
      screeningID: data['screeningID'],
      seat: List<String>.from(data['seat']),
      subtotal: data['subtotal'],
      total: data['total'],
      userID: data['userID'],
      voucherID: data['voucherID'],
    );
  }
}
