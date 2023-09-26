import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:interview_studio93/Model/Meals.dart';
import 'package:interview_studio93/Model/Product.dart';

class NormalMealsScreen extends StatefulWidget {
  const NormalMealsScreen({super.key});

  @override
  State<NormalMealsScreen> createState() => _NormalMealsScreenState();
}

class _NormalMealsScreenState extends State<NormalMealsScreen> {
  List<Meals> list = [], defaultList = [];

  Meals makeMeal(String mealName, List<Product> products, int totalCalories) {
    Meals meals = Meals(mealName, Icons.sunny, products, totalCalories);
    return meals;
  }

  @override
  void initState() {
    //meal 1
    Product product = Product("Spicy bacon Cheese Toast", 312);
    Product product1 = Product("Almond Milk", 200);
    // Product product2 = Product("Total", "624 Cals");
    List<Product> products = [product, product1];
    list.add(makeMeal("Meal One", products, 623));

    //meal 2
    list.add(makeMeal("Meal Two", [], 0));

    //meal 3
    list.add(makeMeal("Meal Three", [], 0));

    //meal 4
    list.add(makeMeal("Meal Four", [], 0));

    //meal 5
    list.add(makeMeal("Meal Five", [], 0));

    //meal 6
    Product product6 = Product("Spicy bacon Cheese Toast1", 60);
    Product product7 = Product("Almond Milk2", 500);
    // Product product2 = Product("Total", "624 Cals");
    List<Product> products6 = [product6, product7];
    list.add(makeMeal("Meal Six", products6, 0));

    defaultList = list;
    super.initState();
  }

  int _selectedIndex = -1;
  int _selectedEditIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 5.0,
            bottom: 5.0,
          ),
          color: const Color(0xFFF1EEE6),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Meals",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        list = defaultList;
                      });
                    },
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Color(0xFF2F2A25),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, position) {
                    return listItem(position, list[position].mealName, list[position].icon, list[position].products);
                  },
                  itemCount: list.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(int position, String mealName, IconData iconData, List<Product> products) {
    final isExpanded = position == _selectedIndex;
    final isSelectedForEdit = position == _selectedEditIndex;
    return InkWell(
      onTap: () {
        log("onListItemClicked");
        if (products.isNotEmpty) {
          setState(() {
            if (isSelectedForEdit) {
              _selectedEditIndex = -1;
            } else {
              _selectedEditIndex = position;
            }
            _selectedIndex = isExpanded ? -1 : position;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: position != list.length - 1 ? 5.0 : 0.0,
        ),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 70.0,
                  width: 70.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1EEE6),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Icon(iconData),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mealName,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    products.isNotEmpty
                        ? Row(
                            children: [
                              editButton(
                                "Edit",
                                10.0,
                                FontWeight.w400,
                                const Color(0xFF2F2A25),
                                1.0,
                                onTap: () {
                                  setState(() {
                                    if (isSelectedForEdit) {
                                      _selectedEditIndex = -1; // Cancel editing
                                    } else {
                                      _selectedEditIndex = position; // Start editing
                                    }
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              const Icon(
                                Icons.favorite_border,
                                size: 18.0,
                                color: Color(0xFF2F2A25),
                              ),
                            ],
                          )
                        : Container(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              top: 1.0,
                              bottom: 1.0,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFFA8A4A0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            child: const Text(
                              "No Products",
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFffffff),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
            isExpanded
                ? products.isNotEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              top: 15.0,
                              bottom: 15.0,
                            ),
                            decoration: const BoxDecoration(
                                color: Color(0xFFF1EEE6),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                )),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, productPosition) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Spicy bacon Cheese Toast",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFFBAB6B1),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${products[productPosition].calories} Cals",
                                                style: const TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF5F554A),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              isSelectedForEdit
                                                  ? IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints: const BoxConstraints(),
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.arrow_circle_right_rounded,
                                                        color: Color(0xFF5F554A),
                                                      ),
                                                    )
                                                  : IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints: const BoxConstraints(),
                                                      onPressed: () {
                                                        setState(() {
                                                          products.removeAt(productPosition);
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.cancel,
                                                        color: Color(0xFFE08A84),
                                                      ),
                                                    ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.white,
                                      height: 2.0,
                                      thickness: 1.0,
                                    ),
                                    if (productPosition == products.length - 1)
                                      Container(
                                        margin: const EdgeInsets.only(
                                          top: 10.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF94B69E)),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                right: 30.0,
                                              ),
                                              child: Text(
                                                getAllProductsCalories(products).toString(),
                                                style: const TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF94B69E),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      const SizedBox(),
                                  ],
                                );
                              },
                              itemCount: products.length,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget editButton(String text, double fontSize, FontWeight fontWeight, Color borderColor, borderWidth,
      {required Function() onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 1.0,
          bottom: 1.0,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }

  double getAllProductsCalories(List<Product> products) {
    double total = 0.0;
    for (int i = 0; i < products.length; i++) {
      total += products[i].calories;
    }
    return total;
  }
}
