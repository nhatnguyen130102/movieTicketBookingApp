import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/location_model.dart';

class LocationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<LocationModel>> getAllLocations() async {
    List<LocationModel> locations = [];
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('location').get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        locations.add(LocationModel.fromMap(doc));
      }
    } catch (e) {
      print("Error getting locations: $e");
    }

    return locations;
  }

  // Future<List<LocationModel>> getLocationByCinema(List<String> listLocation) async{
  //   try{
  //     if(listLocation.isNotEmpty){
  //       List<LocationModel> getListLocation;
  //       for(int i = 0; i < listLocation.length; i++){
  //
  //       }
  //     }
  //   }
  //   catch (e){
  //     return [];
  //   }
  // }

  // lấy ra danh sách location từ danh sách cinema đã lấy được từ screening
  Future<List<String>> getLocationByCinema(
      Future<List<String>> getCinemaByScreening) async {
    try {
      List<String> listCinema = await getCinemaByScreening;
      List<String> listLocation = [];

      for (String e in listCinema) {
        DocumentSnapshot documentSnapshot = await _firestore
            .collection('screening')
            .where('movieID', isEqualTo: e)
            .get()
            .then((querySnapshot) => querySnapshot.docs.first);

        // Trích xuất dữ liệu từ DocumentSnapshot và gán vào biến tempCinema
        Map<String, dynamic> data = (documentSnapshot.data() as Map<String, dynamic>);
        String tempCinema = data['cinema']; // Giả sử 'cinema' là một trường trong tài liệu
        if(!listLocation.contains(tempCinema)){
          listLocation.add(tempCinema);
        }
      }
      return listLocation;
    } catch (e) {
      print("Error getting location by cinema: $e");
      return [];
    }
  }
}
