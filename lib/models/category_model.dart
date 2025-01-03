import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

List<CategoryModel> categories = [
  CategoryModel(name: 'Chair', icon: Symbols.chair_rounded),
  CategoryModel(name: 'Table', icon: Symbols.table_restaurant_rounded),
  CategoryModel(name: 'Cabinet', icon: Symbols.shelves_rounded),
  CategoryModel(name: 'Vase', icon: Symbols.potted_plant_rounded),
  CategoryModel(name: 'Lamp', icon: Symbols.table_lamp_rounded),
];

class CategoryModel {
  final String name;
  final IconData icon;

  CategoryModel({required this.name, required this.icon});
}
