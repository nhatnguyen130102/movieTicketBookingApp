import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/format_model.dart';

class FormatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<FormatModel> getFormatByID(String formatID)async{
    try{
      QuerySnapshot querySnapshot = await _firestore.collection('format').where('formatID', isEqualTo: formatID).get();
      return querySnapshot.docs.map((e) => FormatModel.fromMap(e)).first;
    }
    catch (e){
      throw e;
    }
  }
  Future<List<FormatModel>> getAllFormat() async {
    try{
      QuerySnapshot querySnapshot = await _firestore.collection('format').get();
      return querySnapshot.docs.map((e) => FormatModel.fromMap(e)).toList();
    }
    catch (e){
      throw e;
    }
  }
  Future<void> createFormat({
    required String name,
  }) async {
    try {
      QuerySnapshot querySnapshot =
      await _firestore.collection('format').get();
      List<FormatModel> _listLocation =
      querySnapshot.docs.map((e) => FormatModel.fromMap(e)).toList();
      String locationID = 'format' + (_listLocation.length + 1).toString();
      await _firestore.collection('format').doc(locationID).set({
        'formatID': locationID,
        'name': name,
      });
    } catch (e) {
      throw Exception('Failed to create voucher: $e');
    }
  }

  Future<void> editFormat({
    required String formatID,
    required String name,
  }) async {
    try {
      await _firestore.collection('format').doc(formatID).set({
        'formatID': formatID,
        'name': name,
      });
    } catch (e) {
      throw Exception('Failed to create voucher: $e');
    }
  }
}
