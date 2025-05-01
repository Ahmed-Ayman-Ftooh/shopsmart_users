import 'package:flutter/material.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/PaymentScreen';

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TitlesTextWidget(label: "Checkout Screen")),
      bottomSheet: CartBottomCheckout(ontap: () {}, title: "Purshase"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map),
                    SizedBox(width: 10),
                    Text('Selet your Address First'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [TitlesTextWidget(label: "Payment Method")],
          ),
        ],
      ),
    );
  }
}
