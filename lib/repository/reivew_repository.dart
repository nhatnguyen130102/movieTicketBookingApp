import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:project_1/model/user_model.dart';

import '../model/movie_model.dart';

class Review_Repository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addReview(
      double rating, String review, String userID, String movieID) async {
    try {
      // Tạo một đối tượng UserRating từ các thông tin được truyền vào
      DateTime _today = DateTime.now();
      DateFormat getDateTime = DateFormat('dd/MM/yyyy');
      String todayFormat = DateFormat('dd/MM/yyyy').format(DateTime.now());
      String todayFormatID =
          DateFormat('ddMMyyyyHHmmss').format(DateTime.now());
      String _userRatingID = userID + todayFormatID;
      Map<String, dynamic> userRatingData = {
        'date': todayFormat, // Lấy ngày hiện tại
        'ratingStar': rating,
        'review': review,
        'userID': userID,
        'like': 0,
        'userRatingID': _userRatingID,
      };

      // Thực hiện cập nhật tài liệu phim có movieID tương ứng
      await _firestore
          .collection('movie')
          .doc(movieID)
          .collection('userRating')
          .doc(_userRatingID)
          .set(userRatingData);
    } catch (e) {
      print('Error adding review: $e');
      throw e;
    }
  }

  Future<List<UserRating>> allRating(String movieID) async {
    try {
      QuerySnapshot _getRating = await _firestore
          .collection('movie')
          .doc(movieID)
          .collection('userRating')
          .get();
      List<UserRating> _listRating;
      _listRating = _getRating.docs.map((e) => UserRating.fromMap(e)).toList();
      return _listRating;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> checkReview(String userID, String movieID) async {
    try {
      QuerySnapshot _checkReview = await _firestore
          .collection('movie')
          .doc(movieID)
          .collection('userRating')
          .where('userID', isEqualTo: userID)
          .get();
      UserModel getUser =
          _checkReview.docs.map((e) => UserModel.fromMap(e)).first;
      if (getUser != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int> countRating(String movieID) async {
    try {
      QuerySnapshot countRating = await _firestore
          .collection('movie')
          .doc(movieID)
          .collection('userRating')
          .get();
      List<UserRating?> _listUserRating =
          countRating.docs.map((e) => UserRating.fromMap(e)).toList();
      if (_listUserRating != null) {
        int _count = 0;
        while (_count < _listUserRating.length) {
          _count++;
        }
        return _count;
      } else {
        return 0;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> avgRating() async {
    try {
      QuerySnapshot _listMovieSS = await _firestore.collection('movie').get();
      List<MovieModel> _listMovie =
          _listMovieSS.docs.map((e) => MovieModel.fromMap(e)).toList();
      for (MovieModel _itemMovie in _listMovie) {
        Map<String, dynamic> _updateRatingFirst = {
          'rating': 0,
        };
        await _firestore
            .collection('movie')
            .doc(_itemMovie.movieID)
            .set(_updateRatingFirst, SetOptions(merge: true));

        double _avgRating = 0;
        int _count = await countRating(_itemMovie.movieID);
        QuerySnapshot _listRatingSS = await _firestore
            .collection('movie')
            .doc(_itemMovie.movieID)
            .collection('userRating')
            .get();
        List<UserRating> _listRating =
            _listRatingSS.docs.map((e) => UserRating.fromMap(e)).toList();
        if (_listRating != null) {
          double _totalRating = 0;
          for (UserRating _item in _listRating) {
            _totalRating += _item.ratingStar;
          }
          _avgRating = _totalRating / _count;
        }
        Map<String, dynamic> _updateRating = {
          'rating': _avgRating,
        };
        await _firestore
            .collection('movie')
            .doc(_itemMovie.movieID)
            .set(_updateRating, SetOptions(merge: true));
      }
    } catch (e) {
      throw e;
    }
  }

  // Future<void> likeRating(
  //     String userID, String userRatingID, String movieID) async {
  //   try {
  //     QuerySnapshot querySnapshot = await _firestore
  //         .collection('movie')
  //         .doc(movieID)
  //         .collection('userRating')
  //         .doc(userRatingID)
  //         .collection('userLike')
  //         .where('userID', isEqualTo: userID)
  //         .get();
  //     UserLike _item = querySnapshot.docs.map((e) => UserLike.fromMap(e)).first;
  //     if (_item != null) {
  //       await _firestore
  //           .collection('movie')
  //           .doc(movieID)
  //           .collection('userRating')
  //           .doc(userRatingID)
  //           .collection('userLike')
  //           .doc(_item.userLikeID)
  //           .delete();
  //     } else {
  //       String todayFormatID =
  //           DateFormat('ddMMyyyyHHmmss').format(DateTime.now());
  //       String _userLikeID = userID + todayFormatID;
  //       // Map<String, dynamic> _like = {
  //       //   'userLikeID': _userLikeID,
  //       //   'userID': userID,
  //       // };
  //       await _firestore
  //           .collection('movie')
  //           .doc(movieID)
  //           .collection('userRating')
  //           .doc(userRatingID)
  //           .collection('userLike')
  //           .doc(_userLikeID)
  //           .set({
  //         'userLikeID': _userLikeID,
  //         'userID': userID,
  //       });
  //       QuerySnapshot _item = await _firestore
  //           .collection('movie')
  //           .doc(movieID)
  //           .collection('userRating')
  //           .where('userRatingID', isEqualTo: userRatingID)
  //           .get();
  //       UserRating _userRating =
  //           _item.docs.map((e) => UserRating.fromMap(e)).first;
  //       Map<String, dynamic> _updateUserRating = {
  //         'like': _userRating.like + 1,
  //       };
  //       await _firestore
  //           .collection('movie')
  //           .doc(movieID)
  //           .collection('userRating')
  //           .doc(userRatingID)
  //           .set(_updateUserRating, SetOptions(merge: true));
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<bool> checkLike(
      String userID, String movieID, String userRatingID) async {
    try {
      QuerySnapshot _checkReview = await _firestore
          .collection('movie')
          .doc(movieID)
          .collection('userRating')
          .doc(userRatingID)
          .collection('userLike')
          .where('userID', isEqualTo: userID)
          .get();
      UserModel getUser =
          _checkReview.docs.map((e) => UserModel.fromMap(e)).first;
      if (getUser != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> likeRatingTemp(
      String userID, String userRatingID, String movieID) async {
    DocumentSnapshot  _checkLikeSS = await _firestore
        .collection('movie')
        .doc(movieID)
        .collection('userRating')
        .doc(userRatingID)
        .collection('userLike')
        .doc(userID)
        .get();

    if (_checkLikeSS.exists) {
      await _firestore
          .collection('movie')
          .doc(movieID)
          .collection('userRating')
          .doc(userRatingID)
          .collection('userLike')
          .doc(userID)
          .delete();
      QuerySnapshot _item = await _firestore
          .collection('movie')
          .doc(movieID)
          .collection('userRating')
          .where('userRatingID', isEqualTo: userRatingID)
          .get();
      UserRating _userRating = _item.docs.map((e) => UserRating.fromMap(e)).first;
      Map<String, dynamic> update = {
        'like': _userRating.like - 1,
      };
      await _firestore
          .collection('movie')
          .doc(movieID)
          .collection('userRating')
          .doc(userRatingID)
          .set(update, SetOptions(merge: true));
    }
    else{
      await _firestore
          .collection('movie')
          .doc(movieID)
          .collection('userRating')
          .doc(userRatingID)
          .collection('userLike')
          .doc(userID)
          .set({
        'userID': userID,
      });
      QuerySnapshot _item = await _firestore
          .collection('movie')
          .doc(movieID)
          .collection('userRating')
          .where('userRatingID', isEqualTo: userRatingID)
          .get();
      UserRating _userRating = _item.docs.map((e) => UserRating.fromMap(e)).first;
      Map<String, dynamic> update = {
        'like': _userRating.like + 1,
      };
      await _firestore
          .collection('movie')
          .doc(movieID)
          .collection('userRating')
          .doc(userRatingID)
          .set(update, SetOptions(merge: true));
    }
  }
}
