import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/Models/order_model.dart';
import 'package:shopsmart_users/providers/order_provider.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

import 'orders_widget.dart';

class OrdersScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreenFree({super.key});

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(label: 'Placed orders'),
        actions: [
          IconButton(
            onPressed: () {
              MyAppMethods.showErrorORWarningDialog(
                isError: false,
                context: context,
                subtitle: "Remove Items",
                fct: () async {
                  await ordersProvider.deleteAllOrders();
                  await ordersProvider.clearOrders();
                },
              );
            },
            icon: const Icon(Icons.delete_forever_rounded, color: Colors.red),
          ),
        ],
      ),
      body: FutureBuilder<List<OrdersModelAdvanced>>(
        future: ordersProvider.fetchOrder(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: SelectableText(
                "An error has been occured ${snapshot.error}",
              ),
            );
          } else if (!snapshot.hasData || ordersProvider.getOrders.isEmpty) {
            return EmptyBagWidget(
              imagePath: AssetsManager.orderBag,
              title: "No orders has been placed yet",
              subtitle: "",
              buttonText: "Shop now",
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: OrdersWidgetFree(
                  ordersModelAdvanced: ordersProvider.getOrders[index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        }),
      ),
    );
  }
}
