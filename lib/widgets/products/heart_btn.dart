import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/services/my_app_method.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({
    super.key,
    this.size = 22,
    this.color = Colors.transparent,
    required this.prouductId,
  });
  final double size;
  final Color color;
  final String prouductId;
  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final wishlistprovider = Provider.of<WishlistProvider>(context);
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color),
      child: IconButton(
        style: IconButton.styleFrom(shape: const CircleBorder()),
        onPressed: () async {
          setState(() {
            isloading = true;
          });
          try {
            if (wishlistprovider.getWishlisttItems.containsKey(
              widget.prouductId,
            )) {
              wishlistprovider.removeWishlistItemFromFirebase(
                wishlisttId:
                    wishlistprovider.getWishlisttItems[widget.prouductId]!.id,
                productId: widget.prouductId,
              );
            } else {
              wishlistprovider.addToWishlistFirebase(
                productId: widget.prouductId,
                context: context,
              );
            }
            await wishlistprovider.fetchWishlist();
          } catch (e) {
            if (!mounted) return;
            MyAppMethods.showErrorORWarningDialog(
              context: context,
              subtitle: e.toString(),
              fct: () {},
            );
          } finally {
            setState(() {
              isloading = false;
            });
          }
        },
        icon:
            isloading
                ? CircularProgressIndicator()
                : Icon(
                  wishlistprovider.isProductInWishlist(
                        productId: widget.prouductId,
                      )
                      ? IconlyBold.heart
                      : IconlyLight.heart,
                  size: widget.size,
                  color:
                      wishlistprovider.isProductInWishlist(
                            productId: widget.prouductId,
                          )
                          ? Colors.red
                          : Colors.grey.shade800,
                ),
      ),
    );
  }
}
