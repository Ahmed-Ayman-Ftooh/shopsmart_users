import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import 'package:shopsmart_users/Models/amount_model/amount_model.dart';
import 'package:shopsmart_users/Models/amount_model/details.dart';
import 'package:shopsmart_users/Models/item_list_model/item.dart';
import 'package:shopsmart_users/Models/item_list_model/item_list_model.dart';
import 'package:shopsmart_users/consts/app_api_keys.dart';
import 'package:shopsmart_users/screens/Payment/Manager/payment_cubit.dart';
import 'package:shopsmart_users/screens/Payment/payment_successful_screen.dart';
import 'package:shopsmart_users/widgets/custom_button.dart';

class CustomButtonBlocCunsumer extends StatelessWidget {
  const CustomButtonBlocCunsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context).pushNamed(PaymentSuccessfulScreen.routName);
        }
        if (state is PaymentFailure) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment failed: ${state.erorrMessage}')),
          );
        }
      },
      builder: (context, state) {
        return CutomButton(
          isLoading: state is PaymentLoading ? true : false,
          text: 'Continue',
          onTap: () {
            var transactiondata = getTransactionData();
            excutePaypalPayment(context, transactiondata);
            // String amount = '100';
            // amount = (int.parse(amount) * 100).toString();
            // PaymentIntentInputModel paymentIntentInputModel =
            //     PaymentIntentInputModel(
            //       customerId: "cus_SDTdllfqV0ACxg",
            //       amount: amount,
            //       currency: 'USD',
            //     );
            // BlocProvider.of<PaymentCubit>(
            //   context,
            // ).makePayment(input: paymentIntentInputModel);
          },
        );
      },
    );
  }

  void excutePaypalPayment(
    BuildContext context,
    ({AmountModel amount, ItemListModel itemList}) transactiondata,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (BuildContext context) => PaypalCheckoutView(
              sandboxMode: true,
              clientId: ApiKeys.clientapiKey,
              secretKey: ApiKeys.secretKeyForPaypal,
              transactions: [
                {
                  "amount": transactiondata.amount.toJson(),
                  "description": "The payment transaction description.",
                  // "payment_options": {
                  //   "allowed_payment_method":
                  //       "INSTANT_FUNDING_SOURCE"
                  // },
                  "item_list": transactiondata.itemList.toJson(),
                },
              ],
              note: "Contact us for any questions on your order.",
              onSuccess: (Map params) async {
                log("onSuccess: $params");
                Navigator.pop(context);
              },
              onError: (error) {
                log("onError: $error");
                Navigator.pop(context);
              },
              onCancel: () {
                print('cancelled:');
                Navigator.pop(context);
              },
            ),
      ),
    );
  }

  ({AmountModel amount, ItemListModel itemList}) getTransactionData() {
    var amount = AmountModel(
      currency: "USD",
      total: "100",
      details: Details(shipping: "0", shippingDiscount: 0, subtotal: "100"),
    );
    List<OrderItem> orders = [
      OrderItem(name: "Apple", quantity: 4, price: "10", currency: "USD"),
      OrderItem(name: "Apple", quantity: 5, price: "12", currency: "USD"),
    ];
    var itemList = ItemListModel(items: orders);
    return (amount: amount, itemList: itemList);
  }
}
