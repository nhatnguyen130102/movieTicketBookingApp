import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/order_model.dart';

class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'order';

  // Thêm đơn hàng mới vào Firestore
  Future<void> addOrder(OrderModel order) async {
    try {
      await _firestore.collection(_collectionPath).add(order.toMap());
    } catch (e) {
      throw Exception('Failed to add order: $e');
    }
  }

  // Lấy danh sách đơn hàng từ Firestore
  Stream<List<OrderModel>> getOrders() {
    try {
      return _firestore.collection(_collectionPath).snapshots().map(
        (snapshot) {
          return snapshot.docs.map(
            (doc) {
              return OrderModel.fromMap(
                  doc.data() as DocumentSnapshot<Object?>);
            },
          ).toList();
        },
      );
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

  // Xóa đơn hàng từ Firestore
  Future<void> deleteOrder(String orderId) async {
    try {
      await _firestore.collection(_collectionPath).doc(orderId).delete();
    } catch (e) {
      throw Exception('Failed to delete order: $e');
    }
  }
}
