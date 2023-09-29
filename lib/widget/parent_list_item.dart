import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Meals.dart';
import '../Model/Product.dart';
import 'child_list_item.dart';
import 'edit_button.dart';

class ParentListItem extends StatefulWidget {
  final int position;
  final int selectedIndex;
  final List<bool> editModeList;
  final List<Product> products;
  final List<Meals> meals;
  final IconData iconData;
  final String mealName;
  final List<Product> productsToDelete;
  final bool isExpanded;

  final bool isEditSelected;
  final bool isEditMode;

  final Function() onParentItemTap, onEditButtonTapped, onSaveButtonTapped, onAddButtonTapped;

  const ParentListItem(
      {super.key,
      required this.position,
      required this.selectedIndex,
      required this.editModeList,
      required this.isExpanded,
      required this.isEditSelected,
      required this.isEditMode,
      required this.products,
      required this.meals,
      required this.iconData,
      required this.mealName,
      required this.productsToDelete,
      required this.onParentItemTap,
      required this.onSaveButtonTapped,
      required this.onEditButtonTapped(),
      required this.onAddButtonTapped()});

  @override
  State<ParentListItem> createState() => _ParentListItemState();
}

class _ParentListItemState extends State<ParentListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.products.isNotEmpty) {
          widget.onParentItemTap();
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: widget.position != widget.meals.length - 1 ? 5.0 : 0.0,
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
                      child: Icon(widget.iconData),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.mealName,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        widget.products.isNotEmpty ? showEditOrSaveWidget() : noProductsWidget(),
                      ],
                    ),
                  ],
                ),
                addButtonWidget(),
              ],
            ),
            showProducts(
              isExpanded: widget.isExpanded,
              products: widget.products,
              isEditSelected: widget.isEditSelected,
              productsToDelete: widget.productsToDelete,
            ),
          ],
        ),
      ),
    );
  }

  Widget showEditOrSaveWidget() {
    return widget.isEditMode
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
                  widget.onSaveButtonTapped();
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
                  widget.onEditButtonTapped();
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
          );
  }

  Widget noProductsWidget() {
    return Container(
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
    );
  }

  Widget addButtonWidget() {
    return InkWell(
      onTap: () {
        widget.onAddButtonTapped();
      },
      child: SizedBox(
        height: 75.0,
        width: 60.0,
        child: ClipPath(
          clipper: const ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
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
              decoration: const BoxDecoration(
                color: Color(0xFF302A25),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget showProducts(
    {required bool isExpanded, required List<Product> products, required bool isEditSelected, required List<Product> productsToDelete}) {
  return isExpanded
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
                        productsToDelete: productsToDelete,
                      );
                    },
                    itemCount: products.length,
                  ),
                ),
              ],
            )
          : const SizedBox()
      : const SizedBox();
}
