import 'package:flutter/material.dart';

class WishlistModel with ChangeNotifier {
  final String productId, id;
  WishlistModel({required this.productId, required this.id});
}
