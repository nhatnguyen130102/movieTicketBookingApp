import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/format_model.dart';

class FormatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<FormatModel?> getFormatByID(String formatID)async{
    try{
      QuerySnapshot querySnapshot = await _firestore.collection('format').where('formatID', isEqualTo: formatID).get();
      return querySnapshot.docs.map((e) => FormatModel.fromMap(e)).first;
    }
    catch (e){
      return null;
    }
  }
}
