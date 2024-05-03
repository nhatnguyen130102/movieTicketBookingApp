import 'package:cloud_firestore/cloud_firestore.dart';

class ScreeningModel {
  late String screeningID;
  late String cinemaID;
  late String room;
  late String movieID;
  late String time;
  late List<String> booked = [];
  late String date;
  late String formatID;

  ScreeningModel({
    required this.screeningID,
    required this.cinemaID,
    required this.room,
    required this.movieID,
    required this.time,
    required this.booked,
    required this.date,
    required this.formatID,
  });

  factory ScreeningModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ScreeningModel(
      screeningID: data['screeningID'] ?? '',
      cinemaID: data['cinemaID'] ?? '',
      room: data['room'] ?? '',
      movieID: data['movieID'] ?? '',
      time: data['time'] ?? '',
      booked: List<String>.from(data['booked'] ?? []),
      date: data['date'] ?? '',
      formatID: data['formatID'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cinemaID': cinemaID,
      'room': room,
      'movieID': movieID,
      'time': time,
      'booked': booked,
      'date': date,
      'formatID': formatID,
    };
  }
}
