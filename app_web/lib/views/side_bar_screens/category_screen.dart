import 'package:flutter/cupertino.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = '\category-screen';
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Categories',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
