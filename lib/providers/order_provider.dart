import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/Models/order_model.dart';

class OrdersProvider with ChangeNotifier {
  final List<OrdersModelAdvanced> orders = [];
  List<OrdersModelAdvanced> get getOrders => orders;

  Future<List<OrdersModelAdvanced>> fetchOrder() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var _ = user!.uid;
    try {
      await FirebaseFirestore.instance.collection("ordersAdvanced").get().then((
        orderSnapshot,
      ) {
        orders.clear();
        for (var element in orderSnapshot.docs) {
          orders.insert(
            0,
            OrdersModelAdvanced(
              orderId: element.get('orderId'),
              productId: element.get('productId'),
              userId: element.get('userId'),
              price: element.get('price').toString(),
              productTitle: element.get('productTitle').toString(),
              quantity: element.get('quantity').toString(),
              imageUrl: element.get('imageUrl'),
              userName: element.get('userName'),
              orderDate: element.get('orderDate'),
            ),
          );
        }
      });
      return orders;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteOrder({required String orderId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("ordersAdvanced")
          .doc(orderId)
          .delete();
      orders.removeWhere((element) => element.orderId == orderId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAllOrders() async {
    try {
      for (var order in orders) {
        await FirebaseFirestore.instance
            .collection("ordersAdvanced")
            .doc(order.orderId)
            .delete();
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearOrders() async {
    try {
      orders.clear();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
