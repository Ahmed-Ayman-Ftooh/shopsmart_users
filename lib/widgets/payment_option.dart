import 'package:flutter/material.dart';

class PaymentOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Function()? onTap; // Callback function for tap event

  // Constructor with required parameters
  // selected is a boolean to indicate if the option is selected or not
  // onTap is a callback function to handle tap events
  // Default value for selected is false
  // Default value for selected
  const PaymentOption({
    super.key,
    required this.label,
    required this.icon,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF361449) : Colors.black26,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? Colors.white : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(label, style: const TextStyle(color: Colors.white)),
        onTap: onTap,
      ),
    );
  }
}
