import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_1/model/cinema_model.dart';
import 'package:project_1/model/screening_model.dart';

class CinemaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CinemaModel>> getCinemasByLocationID(String locationID) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('cinema')
          .where('locationID', isEqualTo: locationID)
          .get();

      List<CinemaModel> cinemas = querySnapshot.docs
          .map((doc) => CinemaModel.fromSnapshot(doc))
          .toList();

      return cinemas;
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error getting cinemas by locationID: $e');
      return []; // hoặc trả về null, hoặc đối tượng Error
    }
  }

  Future<CinemaModel?> getCinemaByID(String cinemaID) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('cinema')
          .where('cinemaID', isEqualTo: cinemaID)
          .get();
      CinemaModel item =
          querySnapshot.docs.map((e) => CinemaModel.fromSnapshot(e)).first;
      return item;
    } catch (e) {
      return null;
    }
  }

  // hàm lấy ra danh sách cinemaID mà movie đang
  // Future<List<String>> getCinemaByScreening(Future<List<ScreeningModel>> listScreening) async {
  //  try{
  //    // sử dụng biến kiểu future
  //    List<ScreeningModel> screenings = await listScreening;
  //    List<String> cinemas = [];
  //    // Duyệt qua từng suất chiếu để lấy thông tin về rạp chiếu phim
  //    for (ScreeningModel screening in screenings) {
  //       String tempCinema = screening.cinemaID;
  //      if (!cinemas.contains(tempCinema)) {
  //        cinemas.add(tempCinema);
  //      }
  //    } return cinemas;
  //  }
  //  catch (e){
  //    return[];
  //  }
  // }
  // tạo hàm để lấy ra danh sách CinemaID theo movieID
  // Future<List<CinemaModel>> getAllCinemaByMovieID(String movieID) async {
  //   try {
  //     // lấy ra danh sách screening theo movieID
  //     QuerySnapshot querySnapshot = await _firestore
  //         .collection('screening')
  //         .where('movieID', isEqualTo: movieID)
  //         .get();
  //     // chuyển đổi querysnapshot thành List<Model>
  //     List<ScreeningModel> listScreening =
  //         querySnapshot.docs.map((doc) => ScreeningModel.fromMap(doc)).toList();
  //     // tạo biến để hứng giá trị
  //     List<String> cinemasID = [];
  //     // Duyệt qua từng suất chiếu để lấy thông tin về rạp chiếu phim
  //     for (ScreeningModel screening in listScreening) {
  //       String tempCinema = screening.cinemaID;
  //       if (!cinemasID.contains(tempCinema)) {
  //         cinemasID.add(tempCinema);
  //       }
  //     }
  //     List<CinemaModel> listCinema = [];
  //     for (String item in cinemasID) {
  //       QuerySnapshot querySnapshot = await _firestore
  //           .collection('cinema')
  //           .where('cinemaID', isEqualTo: item)
  //           .get();
  //       CinemaModel temp = querySnapshot as CinemaModel;
  //       if(!listCinema.contains(temp)){
  //         listCinema.add(temp);
  //       }
  //     }
  //     return listCinema;
  //   } catch (e) {
  //     return [];
  //   }
  // }
  Future<List<CinemaModel>> getCinemaByLocationID(String locationID) async {
    try {
      // Khai báo danh sách để lưu các cinemaID
      // List<CinemaModel> cinemaIDs = [];
      // List<CinemaModel> cinemaID2 = [];
      // Set<String> uniqueCinemaID = {};
      // Truy vấn cơ sở dữ liệu Firestore để lấy danh sách các tài liệu từ bảng Screening có movieID tương ứng
      // QuerySnapshot querySnapshot = await _firestore
      //     .collection('screening')
      //     .where('movieID', isEqualTo: movieID)
      //     .get();

      QuerySnapshot querySnapshot = await _firestore
          .collection('cinema')
          .where('locationID', isEqualTo: locationID)
          .get();

      List<CinemaModel> listScreeningModel =
          querySnapshot.docs.map((e) => CinemaModel.fromSnapshot(e)).toList();
      // for (ScreeningModel item in listScreeningModel) {
      //   QuerySnapshot querySnapshot = await _firestore
      //       .collection('cinema')
      //       .where('cinemaID', isEqualTo: item.cinemaID)
      //       .get();
      //   CinemaModel itemCinema =
      //       querySnapshot.docs.map((e) => CinemaModel.fromSnapshot(e)).first;
      //
      //   if (!uniqueCinemaID.contains(itemCinema.cinemaID)) {
      //     uniqueCinemaID.add(itemCinema.cinemaID);
      //     cinemaIDs.add(itemCinema);
      //   }
      // }
      // for (CinemaModel item in cinemaIDs) {
      //   if (item.locationID == locationID) {
      //     cinemaID2.add(item);
      //   }
      // }
      return listScreeningModel;
    } catch (e) {
      // Xử lý lỗi nếu có
      print("Error getting cinemas by movieID: $e");
      return []; // Trả về danh sách rỗng nếu có lỗi
    }
  }

  Future<List<String>> countMovieByCinema(String movieID) async {
    try {
      // Lấy danh sách tất cả các rạp chiếu phim
      QuerySnapshot getCinemas = await _firestore.collection('cinema').get();
      List<CinemaModel> cinemas = getCinemas.docs.map((e) => CinemaModel.fromSnapshot(e)).toList();

      // Lấy danh sách các buổi chiếu của phim có movieID cụ thể
      QuerySnapshot getScreenings = await _firestore.collection('screening').where('movieID', isEqualTo: movieID).get();
      List<ScreeningModel> screenings = getScreenings.docs.map((e) => ScreeningModel.fromMap(e)).toList();

      // Tạo danh sách kết quả để lưu số lượng buổi chiếu của mỗi rạp
      List<String> result = [];

      // Lặp qua từng rạp chiếu phim
      for (var cinema in cinemas) {
        // Đếm số lượng buổi chiếu của rạp đó
        int count = screenings.where((screening) => screening.cinemaID == cinema.cinemaID).length;
        // Tạo chuỗi kết quả có dạng "tên rạp - số lượng buổi chiếu"
        String countString = '${cinema.name} - $count';
        // Thêm vào danh sách kết quả
        result.add(countString);
      }

      return result;
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error in counting screenings by cinema: $e');
      return [];
    }
  }
}
