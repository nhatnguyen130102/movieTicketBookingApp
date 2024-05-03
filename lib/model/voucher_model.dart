import 'package:cloud_firestore/cloud_firestore.dart';

class VoucherModel {
  late String body;
  late String  expDate;
  late String heading;
  late bool isExtraPoint;
  late bool status;
  late String title;
  late String validDate;
  late double value;
  late String voucherID;

  VoucherModel({
    required this.body,
    required this.expDate,
    required this.heading,
    required this.isExtraPoint,
    required this.status,
    required this.title,
    required this.validDate,
    required this.value,
    required this.voucherID,
  });

  factory VoucherModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return VoucherModel(
      body: data['body'] ?? '',
      expDate: data['expDate'] ?? '',
      heading: data['heading'] ?? '',
      isExtraPoint: data['isExtraPoint'] ?? false,
      status: data['status'] ?? false,
      title: data['title'] ?? '',
      validDate: data['validDate'] ?? '',
      value: (data['value'] ?? 0.0).toDouble(),
      voucherID: data['voucherID'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'expDate': expDate,
      'heading': heading,
      'isExtraPoint': isExtraPoint,
      'status': status,
      'title': title,
      'validDate': validDate,
      'value': value,
    };
  }
}
