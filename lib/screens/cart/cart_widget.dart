import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/Models/cart_models.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/product_providers.dart';
import 'package:shopsmart_users/screens/cart/quantity_btm_sheet.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitel_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartModelProvider = Provider.of<CartModels>(context);
    final productProvider = Provider.of<ProductProviders>(context);
    final getCurrProduct = productProvider.findByProdId(
      cartModelProvider.productId,
    );
    Size size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : FittedBox(
          child: IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.productImage,
                      height: size.height * 0.2,
                      width: size.height * 0.2,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  IntrinsicWidth(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.6,
                              child: TitlesTextWidget(
                                label: getCurrProduct.productTitle,
                                maxLines: 2,
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    try {
                                      await cartProvider
                                          .removeCartItemFromFirebase(
                                            cartId: cartModelProvider.cartId,
                                            productId: getCurrProduct.productId,
                                            qty: cartModelProvider.quantity,
                                          );
                                    } catch (error) {
                                      log(error.toString());
                                    }
                                    // cartProvider.removeOneItem(
                                    //   productId: getCurrProduct.productId,
                                    // );
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                ),
                                HeartButtonWidget(
                                  prouductId: getCurrProduct.productId,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SubtitelTextWidget(
                              lable: "${getCurrProduct.productPrice}\$",
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                            const Spacer(),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                side: const BorderSide(
                                  width: 2,
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () async {
                                await showModalBottomSheet(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return QuantityBottomSheetWidget(
                                      cartmodel: cartModelProvider,
                                    );
                                  },
                                );
                              },
                              icon: const Icon(IconlyLight.arrowDown2),
                              label: Text(
                                "Qty: ${cartModelProvider.quantity} ",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
