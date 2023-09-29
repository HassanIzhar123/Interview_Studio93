import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../Model/Meals.dart';
import '../../Model/Product.dart';
import '../../repositories/normal_meals/normal_meals_repository.dart';
import 'normal_meals_state.dart';

class NormalMealsCubit extends Cubit<NormalMealsState> {
  NormalMealsRepository normalMealsRepository;

  NormalMealsCubit(this.normalMealsRepository) : super(NormalMealsInitial());

  void fetchInitialMeals() async {
    emit(NormalMealsLoadingState());
    try {
      List<Meals> list = await normalMealsRepository.getInitialMeals();
      emit(NormalMealsSuccessState(list));
    } on Exception {
      emit(const NormalMealsFailedState("something went wrong"));
    }
  }

  void addProduct(List<Meals> meals, int position) {
    emit(NormalMealsAddProductLoadingState());
    List<Product> products = normalMealsRepository.addProduct(meals[position].products);
    emit(NormalMealsAddProductSuccessState(products, position));
  }
}
