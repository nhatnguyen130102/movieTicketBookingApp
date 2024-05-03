import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  late Timestamp createdAt;
  late String movieID;
  late List<Reservation> reservations;
  late String roomID;
  late double total;

  OrderModel({
    required this.createdAt,
    required this.movieID,
    required this.reservations,
    required this.roomID,
    required this.total,
  });

  factory OrderModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    List<dynamic> reservationsData = doc['reservations'] ?? [];
    List<Reservation> reservations = reservationsData.map((reservationMap) {
      return Reservation.fromMap(reservationMap);
    }).toList();

    return OrderModel(
      createdAt: data['createdAt'] ?? Timestamp.now(),
      movieID: data['movieID'] ?? '',
      reservations: reservations,
      roomID: data['roomID'] ?? '',
      total: (data['total'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> reservationsData =
        reservations.map((reservation) => reservation.toMap()).toList();

    return {
      'createdAt': createdAt,
      'movieID': movieID,
      'reservations': reservationsData,
      'roomID': roomID,
      'total': total,
    };
  }
}

class Reservation {
  late String name;
  late String rowID;
  late String seatID;

  Reservation({
    required this.name,
    required this.rowID,
    required this.seatID,
  });

  factory Reservation.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Reservation(
      name: data['name'] ?? '',
      rowID: data['rowID'] ?? '',
      seatID: data['seatID'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rowID': rowID,
      'seatID': seatID,
    };
  }
}
