import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_studio93/Model/Meals.dart';
import 'package:interview_studio93/Model/Product.dart';
import 'package:interview_studio93/repositories/normal_meals/normal_meals_repository.dart';
import '../bloc/cubit/normal_meals_cubit.dart';
import '../bloc/cubit/normal_meals_state.dart';
import '../widget/parent_list_item.dart';

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
      create: (context) =>
      NormalMealsCubit(NormalMealsRepository())
        ..fetchInitialMeals(),
      child: BlocConsumer<NormalMealsCubit, NormalMealsState>(
        listener: (context, state) {
          log("state: $state");
          if (state is NormalMealsLoadingState) {
            isLoading = true;
          } else if (state is NormalMealsSuccessState) {
            meals = state.meals;
            _editModeList = List.generate(meals.length, (index) => false);
            isLoading = false;
          } else if (state is NormalMealsAddProductSuccessState) {
            final isExpanded = state.mealPosition == _selectedIndex;
            if (!isExpanded) {
              _selectedIndex = isExpanded ? -1 : state.mealPosition;
            }
          }
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
                          final isExpanded = position == _selectedIndex;
                          final isEditSelected = _selectedEditIndex == position;
                          final isEditMode = _editModeList[position];
                          return ParentListItem(
                            position: position,
                            mealName: meals[position].mealName,
                            iconData: meals[position].icon,
                            products: meals[position].products,
                            editModeList: _editModeList,
                            isExpanded: isExpanded,
                            isEditSelected: isEditSelected,
                            isEditMode: isEditMode,
                            meals: meals,
                            productsToDelete: _productsToDelete,
                            selectedIndex: _selectedIndex,
                            onParentItemTap: () {
                              setState(() {
                                _selectedIndex = isExpanded ? -1 : position;
                              });
                            },
                            onSaveButtonTapped: () {
                              setState(() {
                                if (!isExpanded) {
                                  _selectedIndex = isExpanded ? -1 : position;
                                }
                                for (Product product in _productsToDelete) {
                                  meals[position].products.remove(product);
                                }
                                _editModeList[position] = false;
                                _selectedEditIndex = -1; // Clear edit mode
                                _productsToDelete.clear();
                              });
                            },
                            onEditButtonTapped: () {
                              setState(() {
                                if (!isExpanded) {
                                  _selectedIndex = isExpanded ? -1 : position;
                                }
                                _selectedEditIndex = position;
                                _editModeList[position] = true;
                              });
                            },
                            onAddButtonTapped: () {
                              context.read<NormalMealsCubit>().addProduct(meals, position);
                            },
                          );
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
}