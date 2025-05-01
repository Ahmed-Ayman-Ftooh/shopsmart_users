import 'package:flutter/material.dart';
import 'package:shopsmart_users/Models/viewed_prod_model.dart';

import 'package:uuid/uuid.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProdModel> _viewedprodItem = {};

  Map<String, ViewedProdModel> get getViewedprodItem {
    return _viewedprodItem;
  }

  // bool isProductInViewed({required String productId}) {
  //   return _viewedprodItem.containsKey(productId);
  // }

  void addProductToHistory({required String productId}) {
    _viewedprodItem.putIfAbsent(
      productId,
      () => ViewedProdModel(id: Uuid().v4(), productId: productId),
    );

    notifyListeners();
  }

  void clearLocalWishlist() {
    _viewedprodItem.clear();
    notifyListeners();
  }
}
