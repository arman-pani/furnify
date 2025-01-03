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
  final String glbModelUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.company,
    required this.category,
    required this.description,
    required this.prize,
    required this.rating,
    required this.imageUrlList,
    required this.glbModelUrl,
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
      'glbModelUrl': glbModelUrl,
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
      glbModelUrl: map['glbModelUrl'] as String,
    );
  }

  static ProductModel fromJson(Map<String, dynamic> map, String docId) {
    return ProductModel(
      id: docId,
      name: map['name'] as String? ?? '',
      company: map['company'] as String? ?? '',
      category: map['category'] as String? ?? '',
      description: map['description'] as String? ?? '',
      prize: (map['prize'] as num?)?.toDouble() ?? 0.0,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      imageUrlList: map['imageUrlList'] != null
          ? List<String>.from(map['imageUrlList'])
          : [],
      glbModelUrl: map['glbModelUrl'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, company: $company, category: $category, description: $description, prize: $prize, rating: $rating, imageUrlList: $imageUrlList, glbModelUrl: $glbModelUrl)';
  }
}
