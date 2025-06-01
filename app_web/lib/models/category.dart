import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String image;
  final String banner;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.banner,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'image': image, 'banner': banner};
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      banner: json['banner'] as String,
    );
  }
}
