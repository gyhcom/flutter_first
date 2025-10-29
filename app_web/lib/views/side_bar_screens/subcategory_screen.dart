import 'package:app_web/controllers/category_controller.dart';
import 'package:flutter/material.dart';

import '../../models/category.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = 'subcategoryScreen';

  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  late Future<List<Category>> futureCategories;
  Category? selectedCategory;

  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              'SubCategories',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Divider(color: Colors.grey),
        ),
        FutureBuilder(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('카테고리가 없습니다.'));
            } else {
              //Todo: data에 !안 붙이면 에러나는 이유
              //Todo: selectedCategory를 상단에 선언한 이유
              //Todo: DropdownButton에서 value 속성을 selectedCategory로 설정하는 이유
              //Todo: onChanged 콜백 함수에서 setState를 호출하는 이유

              return DropdownButton<Category>(
                hint: Text('카테고리를 선택하세요'),
                items:
                    snapshot.data!.map((Category category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                  print(selectedCategory);
                },
              );
            }
          },
        ),
      ],
    );
  }
}
