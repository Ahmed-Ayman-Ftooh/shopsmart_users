import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/product_providers.dart';
import 'package:shopsmart_users/widgets/subtitel_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({
    super.key,
    required this.ontap,
    required this.title,
  });
  final Function ontap;
  final String title;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProviders>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(top: BorderSide(width: 1, color: Colors.grey)),
      ),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 19,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: TitlesTextWidget(
                        label:
                            "Total (${cartProvider.getCartItems.length} products/${cartProvider.getQty()} Items)",
                        fontSize: 17,
                      ),
                    ),
                    SubtitelTextWidget(
                      lable:
                          "${cartProvider.getTotal(productProvider: productProvider).toStringAsFixed(2)}\$",
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await ontap();
                },
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
