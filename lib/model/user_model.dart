import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String photoURL;
  final String userID;
  final String username;

  final List<BookingItem> booking;

  UserModel({
    required this.email,
    required this.photoURL,
    required this.userID,
    required this.username,
    required this.booking,

  });

  factory UserModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(

      email: data['email'] ?? '',
      photoURL: data['photoURL'] ?? '',
      userID: data['userID'] ?? '',
      username: data['username'] ?? '',
      booking: List<BookingItem>.from((data['booking'] ?? []).map((x) => BookingItem.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'photoURL': photoURL,
      'userID': userID,
      'username': username,
      'booking': booking.map((bookingItem) => bookingItem.toMap()).toList(),
    };
  }
}

class BookingItem {
  final String bookingID;
  final String cinemaID;
  final String movieID;
  final String screeningID;
  final List<String> seat;
  final double subtotal;
  final double total;
  final String voucherID;

  BookingItem({
    required this.bookingID,
    required this.cinemaID,
    required this.movieID,
    required this.screeningID,
    required this.seat,
    required this.subtotal,
    required this.total,
    required this.voucherID,
  });

  factory BookingItem.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BookingItem(
      bookingID:  data['bookingID'] ?? '',
      cinemaID: data['cinemaID'] ?? '',
      movieID: data['movieID'] ?? '',
      screeningID: data['screeningID'] ?? '',
      seat: List<String>.from(data['seat'] ?? []),
      subtotal: data['subtotal'] ?? 0.0,
      total: data['total'] ?? 0.0,
      voucherID: data['voucherID'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingID':bookingID,
      'cinemaID': cinemaID,
      'movieID': movieID,
      'screeningID': screeningID,
      'seat': seat,
      'subtotal': subtotal,
      'total': total,
      'voucherID': voucherID,
    };
  }
}
