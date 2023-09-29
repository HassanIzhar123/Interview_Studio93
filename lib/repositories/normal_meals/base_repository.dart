import '../../Model/Meals.dart';
import '../../Model/Product.dart';

abstract class BaseRepository {
  Future<List<Meals>> getInitialMeals();

  List<Product> addProduct(List<Product> products);
}
