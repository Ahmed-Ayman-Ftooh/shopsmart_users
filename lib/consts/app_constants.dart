import 'package:shopsmart_users/Models/category_models.dart';

import '../services/assets_manager.dart';

class AppConstants {
  static const String productImageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';
  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];
  static List<CategoryModels> categoriesList = [
    CategoryModels(id: "Phones", image: AssetsManager.mobiles, name: "Phones"),
    CategoryModels(id: "Laptops", image: AssetsManager.pc, name: "Laptops"),
    CategoryModels(
      id: "Electronics",
      image: AssetsManager.electronics,
      name: "Electronics",
    ),
    CategoryModels(id: "Watches", image: AssetsManager.watch, name: "Watches"),
    CategoryModels(
      id: "Clothes",
      image: AssetsManager.fashion,
      name: "Clothes",
    ),
    CategoryModels(id: "Shoes", image: AssetsManager.shoes, name: "Shoes"),
    CategoryModels(id: "Books", image: AssetsManager.book, name: "Books"),
    CategoryModels(
      id: "Cosmetics",
      image: AssetsManager.cosmetics,
      name: "Cosmetics",
    ),
    CategoryModels(
      id: "Accessories",
      image: AssetsManager.bagWish,
      name: "Accessories",
    ),
  ];
}
