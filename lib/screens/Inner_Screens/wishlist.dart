import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

import '../../widgets/products/product_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routName = '/WishlistScreen';
  const WishlistScreen({super.key});
  final bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    final wishlistprovider = Provider.of<WishlistProvider>(context);
    return wishlistprovider.getWishlisttItems.isEmpty
        ? Scaffold(
          body: EmptyBagWidget(
            imagePath: AssetsManager.bagWish,
            title: "Your wishlist is empty",
            subtitle:
                'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
            buttonText: "Shop Now",
          ),
        )
        : Scaffold(
          appBar: AppBar(
            title: TitlesTextWidget(
              label: "Wishlist (${wishlistprovider.getWishlisttItems.length})",
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsManager.shoppingCart),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  MyAppMethods.showErrorORWarningDialog(
                    isError: false,
                    context: context,
                    subtitle: "Remove Items",
                    fct: () async {
                      await wishlistprovider.clearWishlistFromFirebase();
                      wishlistprovider.clearLocalWishlist();
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          body: DynamicHeightGridView(
            itemCount: wishlistprovider.getWishlisttItems.length,
            builder: ((context, index) {
              return ProductWidget(
                productId:
                    wishlistprovider.getWishlisttItems.values
                        .toList()[index]
                        .productId,
              );
            }),
            crossAxisCount: 2,
          ),
        );
  }
}
