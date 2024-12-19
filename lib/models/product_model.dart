import 'dart:convert';

class ProductModel {
  final String id;
  final String name;
  final String company;
  final String category;
  final String description;
  final double prize;
  final double rating;
  final List<String> imageUrlList;

  ProductModel({
    required this.id,
    required this.name,
    required this.company,
    required this.category,
    required this.description,
    required this.prize,
    required this.rating,
    required this.imageUrlList,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'company': company,
      'category': category,
      'description': description,
      'prize': prize,
      'rating': rating,
      'imageUrlList': jsonEncode(imageUrlList),
    };
  }

  static ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      company: map['company'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      prize: map['prize'] as double,
      rating: map['rating'] as double,
      imageUrlList: List<String>.from(
        jsonDecode(map['imageUrlList']),
      ),
    );
  }
}
