import 'package:flutter/cupertino.dart';
import 'package:interview_studio93/Model/Product.dart';

class Meals {
  String mealName;
  IconData icon;
  List<Product> products;
  int totalCalories;

  Meals(this.mealName, this.icon, this.products, this.totalCalories);

  @override
  String toString() {
    return 'Meals{mealName: $mealName, icon: $icon, products: $products, totalCalories: $totalCalories}';
  }
}
