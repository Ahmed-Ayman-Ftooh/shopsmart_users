import 'package:flutter/material.dart';
import 'package:shopsmart_users/widgets/payment_option.dart';
import 'package:shopsmart_users/widgets/payment_methods_list_view.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/PaymentScreen';

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<String> paymentMethods = [
    "Master card, VISA",
    "PayPal",
    "Cash on delivery",
  ];
  List<IconData> paymentIcons = [
    Icons.credit_card,
    Icons.account_balance_wallet,
    Icons.money,
  ];
  List<bool> selected = [false, false, false]; // Default values for selected
  bool isSelected = false; // Default value for selected
  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color(0xFFAD73FF); // Purple button


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Checkout screen",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address button
            GestureDetector(
              onTap: () {
                // Handle address selection
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.map, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Select your address first",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Payment Method",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            ListView.builder(
              itemBuilder: ((context, index) {
                return PaymentOption(
                  label: paymentMethods[index],
                  icon: paymentIcons[index],
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                      selected[index] = isSelected;
                    });
                  },
                  selected: selected[index],
                );
              }),
            ),

            // Payment Methods
            // PaymentOption(label: "Master card, VISA", icon: Icons.credit_card,selected: isSelected,),
            // PaymentOption(label: "PayPal", icon: Icons.account_balance_wallet),
            // PaymentOption(label: "Cash on delivery", icon: Icons.money),
            const SizedBox(height: 20),
            const Text(
              "Order Summary",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),
            SummaryRow(
              label: "Subtotal",
              value: "\$2059.98",
              valueColor: Colors.green,
            ),
            SummaryRow(label: "Tax", value: "\$0.00"),

            const Spacer(),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total (2 Products/2 Items)",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$2059.98",
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Purchase Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black54,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Handle purchase
                },
                child: Text(
                  "Purshase",
                  style: TextStyle(color: buttonColor, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
