import 'package:app_web/controllers/category_controller.dart';
import 'package:flutter/material.dart';

import '../../../models/category.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late Future<List<Category>> futureCategories;
  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }
  Widget build(BuildContext context) {
    return  FutureBuilder(future: futureCategories, builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasError){
        return Center(
          child: Text('에러 ${snapshot.error}'),
        );
      } else if(!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(
          child: Text('카테고리가 없습니다.'),
        );
      } else {
        final categories = snapshot.data!;
        return GridView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8),
            itemBuilder: (context, index){
              final category = categories[index];
              return Column(
                children: [
                  Image.network(category.image, height: 100, width: 100,),
                  Text(category.name)
                ],
              );
        });
      }
    });
  }
}
