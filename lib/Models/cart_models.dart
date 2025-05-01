import 'package:flutter/material.dart';

class CartModels with ChangeNotifier {
  final String cartId;
  final String productId;
  final int quantity;
  CartModels({
    required this.cartId,
    required this.productId,
    required this.quantity,
  });
}
