import 'package:flutter/material.dart';
import 'package:shopsmart_users/screens/search_screen.dart';
import 'package:shopsmart_users/widgets/subtitel_text.dart';

class CategoryRoundedWidget extends StatelessWidget {
  const CategoryRoundedWidget({
    super.key,
    required this.image,
    required this.name,
  });

  final String image, name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          SearchScreen.routeName,
          arguments: name,
        );
      },
      child: Column(
        children: [
          Image.asset(image, height: 50, width: 50),
          const SizedBox(height: 15),
          SubtitelTextWidget(
            lable: name,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
