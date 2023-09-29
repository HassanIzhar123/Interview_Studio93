import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../Model/Meals.dart';
import '../../Model/Product.dart';

@immutable
abstract class NormalMealsState extends Equatable {
  const NormalMealsState();

  @override
  List<Object> get props => [];
}

class NormalMealsInitial extends NormalMealsState {}

class NormalMealsLoadingState extends NormalMealsState {}

class NormalMealsSuccessState extends NormalMealsState {
  final List<Meals> meals;

  const NormalMealsSuccessState(this.meals);
}

class NormalMealsFailedState extends NormalMealsState {
  final String message;

  const NormalMealsFailedState(this.message);
}


class NormalMealsAddProductLoadingState extends NormalMealsState {}

class NormalMealsAddProductSuccessState extends NormalMealsState {
  final List<Product> products;
  final int mealPosition;

  const NormalMealsAddProductSuccessState(this.products, this.mealPosition);
}
