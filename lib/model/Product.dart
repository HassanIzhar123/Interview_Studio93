class Product {
  String productName;
  bool toBeDeleted = false;

  @override
  String toString() {
    return 'Product{productName: $productName, calories: ${calories.toString()}}';
  }

  int calories;

  Product(this.productName, this.calories);
}
