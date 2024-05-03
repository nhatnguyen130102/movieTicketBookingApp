import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/basic.dart';

class MovieModel {
  late String movieID; // Document ID
  late String name;
  late String image;
  late String banner;
  late String age;
  late String summary;
  late String date;
  late String trailer;
  late String genre;
  late String director;
  late List<Actor> actor;
  late double rating;
  late String time;

  // Constructor
  MovieModel({
    required this.movieID,
    required this.name,
    required this.image,
    required this.banner,
    required this.age,
    required this.summary,
    required this.date,
    required this.trailer,
    required this.genre,
    required this.director,
    required this.actor,
    required this.rating,
    required this.time
  });

  // Factory method to create MovieModel object from a DocumentSnapshot
  factory MovieModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return MovieModel(
      time: data['time'] ?? '',
      movieID: data['movieID'] ?? '', // Assign Document ID to movieID
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      banner: data['banner'] ?? '',
      age: data['age'] ?? '',
      summary: data['summary'] ?? '',
      date: data['date'] ?? Timestamp.now(),
      trailer: data['trailer'] ?? '',
      genre: data['genre'] ?? '',
      director: data['director'] ?? '',
      actor: List<Actor>.from(
          (data['actor'] ?? []).map((actor) => Actor.fromMap(actor))),
      rating: (data['rating'] ?? 0).toDouble(),
    );
  }

  map(Builder Function(dynamic i) param0) {}
}

class Actor {
  late String name;
  late String image;

  Actor({
    required this.name,
    required this.image,
  });

  factory Actor.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Actor(
      name: data['name'] ?? '',
      image: data['image'] ?? '',
    );
  }
}
