import 'package:cloud_firestore/cloud_firestore.dart';

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
  late List<UserRating> userRating;

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
    required this.time,
    required this.userRating,
  });

  factory MovieModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return MovieModel(
      movieID: data['movieID'] ?? '',
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      banner: data['banner'] ?? '',
      age: data['age'] ?? '',
      summary: data['summary'] ?? '',
      date: data['date'] ?? '',
      trailer: data['trailer'] ?? '',
      genre: data['genre'] ?? '',
      director: data['director'] ?? '',
      actor: List<Actor>.from(
          (data['actor'] ?? []).map((actor) => Actor.fromMap(actor))),
      rating: (data['rating'] ?? 0).toDouble(),
      time: data['time'] ?? '',
      userRating: List<UserRating>.from((data['userRating'] ?? [])
          .map((userRating) => UserRating.fromMap(userRating))),
    );
  }
}

class UserRating {
  late String date;
  late String review;
  late double ratingStar;
  late int like;
  late String userRatingID;
  late String userID;
  late List<Reply> reply;
  late List<UserLike> userLike;


  UserRating({
    required this.date,
    required this.review,
    required this.ratingStar,
    required this.like,
    required this.userRatingID,
    required this.userID,
    required this.reply,
    required this.userLike  ,

  });

  factory UserRating.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserRating(
      date: data['date'] ?? '',
      review: data['review'] ?? '',
      ratingStar: data['ratingStar'] ?? '',
      like:  data['like'] ?? 0,
      userRatingID: data['userRatingID'] ?? '',
      userID: data['userID'] ?? '',
      reply: List<Reply>.from(
          (data['reply'] ?? []).map((reply) => UserRating.fromMap(reply))),
      userLike: List<UserLike >.from(
          (data['userLike'] ?? []).map((userLike) => UserRating.fromMap(userLike))),
    );
  }
}

class Reply {
  late String date;
  late String review;
  late int like;
  late String replyID;
  late String userID;

  Reply({
    required this.date,
    required this.review,
    required this.like,
    required this.replyID,
    required this.userID,
  });

  factory Reply.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Reply(
      date: data['date'] ?? '',
      review: data['review'] ?? '',
      like:  data['like'] ?? 0,
      replyID: data['replyID'] ?? '',
      userID: data['userID'] ?? '',
    );
  }
}

class UserLike {
  late String UserRating;
  late String userID;

  UserLike({
    required this.UserRating,
    required this.userID,
  });

  factory UserLike.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserLike(
      UserRating: data['UserRating'] ?? '',
      userID: data['userID'] ?? '',
    );
  }
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
