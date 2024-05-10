import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_1/model/voucher_model.dart';

class VoucherRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<void> createVoucher(VoucherModel voucher) async {
  //   try {
  //     await _firestore.collection('vouchers').add(voucher.toMap());
  //   } catch (e) {
  //     throw Exception('Failed to create voucher: $e');
  //   }
  // }

  Future<void> createVoucher({
    required String body,
    required String expDate,
    required String heading,
    required bool isExtraPoint,
    required bool status,
    required String title,
    required String validDate,
    required double value,
  }) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('voucher').get();
      List<VoucherModel> _listVoucher =
          querySnapshot.docs.map((e) => VoucherModel.fromFirestore(e)).toList();
      String voucherID = 'voucher' + (_listVoucher.length + 1).toString();
      await _firestore.collection('voucher').doc(voucherID).set({
        'body': body,
        'expDate': expDate,
        'heading': heading,
        'isExtraPoint': isExtraPoint,
        'status': status,
        'title': title,
        'validDate': validDate,
        'value': value,
        'voucherID': voucherID,
      });
    } catch (e) {
      throw Exception('Failed to create voucher: $e');
    }
  }

  Future<void> editVoucher({
    required String body,
    required String expDate,
    required String heading,
    required bool isExtraPoint,
    required bool status,
    required String title,
    required String validDate,
    required double value,
    required String voucherID,
  }) async {
    try {
      await _firestore.collection('voucher').doc(voucherID).set({
        'body': body,
        'expDate': expDate,
        'heading': heading,
        'isExtraPoint': isExtraPoint,
        'status': status,
        'title': title,
        'validDate': validDate,
        'value': value,
        'voucherID': voucherID,
      });
    } catch (e) {
      throw Exception('Failed to create voucher: $e');
    }
  }

  Future<List<VoucherModel>> getAllVouchers() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('voucher').get();
      return querySnapshot.docs
          .map((doc) => VoucherModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get vouchers: $e');
    }
  }

  Future<VoucherModel> getVoucherDetail(String voucherID) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('voucher').doc(voucherID).get();
      return VoucherModel.fromFirestore(docSnapshot);
    } catch (e) {
      throw Exception('Failed to get voucher detail: $e');
    }
  }

  Future<void> updateVoucher(VoucherModel voucher) async {
    try {
      await _firestore
          .collection('voucher')
          .doc(voucher.voucherID)
          .update(voucher.toMap());
    } catch (e) {
      throw Exception('Failed to update voucher: $e');
    }
  }

  Future<void> deleteVoucher(String voucherID) async {
    try {
      await _firestore.collection('voucher').doc(voucherID).delete();
    } catch (e) {
      throw Exception('Failed to delete voucher: $e');
    }
  }

}
