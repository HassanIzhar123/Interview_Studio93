import 'package:flutter/material.dart';

import '../../Model/Meals.dart';
import '../../Model/Product.dart';
import 'base_repository.dart';

class NormalMealsRepository extends BaseRepository {
  List<Meals> list = [];

  @override
  Future<List<Meals>> getInitialMeals() async {
    //meal 1
    Product product = Product("Spicy bacon Cheese Toast", 312);
    Product product1 = Product("Almond Milk", 200);
    // Product product2 = Product("Total", "624 Cals");
    List<Product> products = [product, product1];
    list.add(_makeMeal("Meal One", products, 623));

    //meal 2
    list.add(_makeMeal("Meal Two", [], 0));

    //meal 3
    list.add(_makeMeal("Meal Three", [], 0));

    //meal 4
    list.add(_makeMeal("Meal Four", [], 0));

    //meal 5
    list.add(_makeMeal("Meal Five", [], 0));

    //meal 6
    List<Product> products6 = [Product("Spicy bacon Cheese Toast1", 60), Product("Almond Milk2", 500)];
    list.add(_makeMeal("Meal Six", products6, 0));
    List<Product> products7 = [Product("Spicy bacon Cheese Toast1", 60), Product("Almond Milk2", 500)];
    list.add(_makeMeal("Meal Seven", products7, 0));
    return list;
  }

  @override
  List<Product> addProduct(List<Product> products) {
    products.add(_addDummyProduct());
    return products;
  }

  Meals _makeMeal(String mealName, List<Product> products, int totalCalories) {
    Meals meals = Meals(mealName, Icons.sunny, products, totalCalories);
    return meals;
  }

  Product _addDummyProduct() {
    return Product("Spicy bacon Cheese Toast", 312);
  }
}
