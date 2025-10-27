class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

void main() {
  var data = [
    {"id": 1, "name": "음식"},
    {"id": 2, "name": "여행"}
  ];

  List<Category> categories = data.map((category) => Category.fromJson(category)).toList();

  print(categories[1].name); // 출력: 음식
}