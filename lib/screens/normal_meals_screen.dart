import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_studio93/Model/Meals.dart';
import 'package:interview_studio93/Model/Product.dart';
import 'package:interview_studio93/repositories/normal_meals/normal_meals_repository.dart';
import 'package:interview_studio93/widget/child_list_item.dart';
import '../bloc/cubit/normal_meals_cubit.dart';
import '../bloc/cubit/normal_meals_state.dart';
import '../widget/edit_button.dart';

class NormalMealsScreen extends StatefulWidget {
  const NormalMealsScreen({super.key});

  @override
  State<NormalMealsScreen> createState() => _NormalMealsScreenState();
}

class _NormalMealsScreenState extends State<NormalMealsScreen> {
  bool isLoading = false;
  List<Meals> meals = [];
  int _selectedIndex = -1;
  int _selectedEditIndex = -1;
  List<bool> _editModeList = [];
  final List<Product> _productsToDelete = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NormalMealsCubit(NormalMealsRepository())..fetchInitialMeals(),
      child: BlocConsumer<NormalMealsCubit, NormalMealsState>(
        listener: (context, state) {
          log("state: $state");
          if (state is NormalMealsLoadingState) {
            isLoading = true;
          } else if (state is NormalMealsSuccessState) {
            meals = state.meals;
            _editModeList = List.generate(meals.length, (index) => false);
            isLoading = false;
          } else if (state is NormalMealsAddProductSuccessState) {}
        },
        builder: (context, state) {
          log("list: ${meals.toString()}");
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Color(0xFF2F2A25),
                          ),
                        ),
                      ],
                    ),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, position) {
                                return parentListItem(context, position, meals[position].mealName, meals[position].icon,
                                    meals[position].products);
                              },
                              itemCount: meals.length,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget parentListItem(
      BuildContext context, int position, String mealName, IconData iconData, List<Product> products) {
    log("productscheckl:${position} ${products.toString()}");
    final isExpanded = position == _selectedIndex;
    final isEditSelected = _selectedEditIndex == position;
    final isEditMode = _editModeList[position];
    return InkWell(
      onTap: () {
        if (products.isNotEmpty) {
          setState(() {
            _selectedIndex = isExpanded ? -1 : position;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: position != meals.length - 1 ? 5.0 : 0.0,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 70.0,
                      width: 70.0,
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        top: 10.0,
                        bottom: 10.0,
                      ),
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
                            ? isEditMode
                                ? Row(
                                    children: [
                                      EditButton(
                                        text: "Save",
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        texColor: const Color(0xFF94B69E),
                                        borderColor: const Color(0xFF94B69E),
                                        borderWidth: 1.0,
                                        onTap: () {
                                          setState(() {
                                            // Remove products marked for deletion
                                            for (Product product in _productsToDelete) {
                                              products.remove(product);
                                            }
                                            _editModeList[position] = false;
                                            _selectedEditIndex = -1; // Clear edit mode
                                            _productsToDelete.clear();
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
                                : Row(
                                    children: [
                                      EditButton(
                                        text: "Edit",
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        texColor: const Color(0xFF2F2A25),
                                        borderColor: const Color(0xFF2F2A25),
                                        borderWidth: 1.0,
                                        onTap: () {
                                          setState(() {
                                            _selectedEditIndex = position;
                                            _editModeList[position] = true;
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
                Container(
                  decoration: const BoxDecoration(
                    // color: Colors.orange,
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFFF1EEE6),
                        width: 5.0,
                      ),
                      bottom: BorderSide(
                        color: Color(0xFFF1EEE6),
                        width: 5.0,
                      ),
                    ),
                  ),
                  child: Container(
                    height: 75.0,
                    width: 60.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF302A25),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                    ),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {},
                      splashColor: Colors.red,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     // context.read<NormalMealsCubit>().addProduct(meals, position);
                //   },
                //   child: SizedBox(
                //     height: 75.0,
                //     width: 60.0,
                //     child: ClipPath(
                //       clipper: const ShapeBorderClipper(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(5.0),
                //             topRight: Radius.circular(20.0),
                //             bottomLeft: Radius.circular(5.0),
                //             bottomRight: Radius.circular(5.0),
                //           ),
                //         ),
                //       ),
                //       child: Container(
                //         decoration: const BoxDecoration(
                //           // color: Colors.orange,
                //           border: Border(
                //             left: BorderSide(
                //               color: Color(0xFFF1EEE6),
                //               width: 5.0,
                //             ),
                //             bottom: BorderSide(
                //               color: Color(0xFFF1EEE6),
                //               width: 5.0,
                //             ),
                //           ),
                //         ),
                //         child: Container(
                //           decoration: const BoxDecoration(
                //             color: Color(0xFF302A25),
                //             borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(5.0),
                //               topRight: Radius.circular(20.0),
                //               bottomLeft: Radius.circular(5.0),
                //               bottomRight: Radius.circular(5.0),
                //             ),
                //           ),
                //           child: InkWell(
                //             customBorder: const CircleBorder(),
                //             onTap: () {},
                //             splashColor: Colors.red,
                //             child: const Icon(
                //               Icons.add,
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
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
                            margin: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
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
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, productPosition) {
                                return ChildListItem(
                                  products: products,
                                  productPosition: productPosition,
                                  isEditSelected: isEditSelected,
                                  productsToDelete: _productsToDelete,
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
}
