import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../model/movie_model.dart';

class MovieRepository {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<List<MovieModel>> getMovies() async {
    QuerySnapshot querySnapshot = await _firebase.collection('movie').get();
    return querySnapshot.docs.map((e) => MovieModel.fromMap(e)).toList();
  }

  Future<MovieModel?> getMoviesByMovieID(String movieID) async {
    try {
      QuerySnapshot querySnapshot = await _firebase
          .collection('movie')
          .where('movieID', isEqualTo: movieID)
          .get();

      MovieModel item =
          querySnapshot.docs.map((e) => MovieModel.fromMap(e)).first;

      return item;
    } catch (e) {
      print("Error fetching movies by movieID: $e"); // In ra lỗi để gỡ rối
      return null; // Trả về danh sách rỗng trong trường hợp có lỗi
    }
  }

  Future<List<Actor>> getAllActorsForMovie(String movieId) async {
    try {
      List<Actor> actors = [];
      QuerySnapshot querySnapshot = await _firebase
          .collection('movie')
          .doc(movieId)
          .collection('actor')
          .get();
      querySnapshot.docs.forEach((doc) {
        actors.add(
          Actor(
            name: doc['name'],
            image: doc['image'],
          ),
        );
      });
      return actors;
    } catch (e) {
      return [];
    }
  }

  Future<List<MovieModel>> searchMovies(String search) async {
    try {
      if (search == '') {
        QuerySnapshot _listMovie = await _firebase.collection('movie').get();
        return _listMovie.docs.map((e) => MovieModel.fromMap(e)).toList();
      } else {
        List<MovieModel> _getNameMovie = [];
        QuerySnapshot _listMovie = await _firebase.collection('movie').get();
        List<MovieModel> _listMovieModel =
            _listMovie.docs.map((e) => MovieModel.fromMap(e)).toList();
        for (MovieModel _itemMovie in _listMovieModel) {
          if (_itemMovie.name.toLowerCase().contains(search.toLowerCase())) {
            _getNameMovie.add(_itemMovie);
          }
        }
        return _getNameMovie;
      }
    } catch (error) {
      print('Error searching movies: $error');
      return [];
    }
  }

  Future<void> createMovie({
    required String name,
    required String image,
    required String banner,
    required String age,
    required String summary,
    required String date,
    required String trailer,
    required String genre,
    required String director,
    required double rating,
    required String time,
  }) async {
    try {
      String todayFormatID = DateFormat('ddMMyyyyhhmmss').format(DateTime.now());
      String movieID = 'movie' + todayFormatID;
      await _firebase.collection('movie').doc(movieID).set({
        'movieID': movieID,
        'name': name,
        'image': image,
        'banner': banner,
        'age': age,
        'summary': summary,
        'date': date,
        'trailer': trailer,
        'genre': genre,
        'director': director,
        'rating': rating,
        'time': time,
      });
    } catch (e) {
      throw Exception('Failed to create voucher: $e');
    }
  }
}
