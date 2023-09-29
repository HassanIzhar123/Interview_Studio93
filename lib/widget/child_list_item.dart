import 'package:flutter/material.dart';
import '../Model/Product.dart';

class ChildListItem extends StatefulWidget {
  final List<Product> products;
  final int productPosition;
  final bool isEditSelected;
  final List<Product> productsToDelete;

  const ChildListItem(
      {super.key,
      required this.products,
      required this.productPosition,
      required this.isEditSelected,
      required this.productsToDelete});

  @override
  State<ChildListItem> createState() => _ChildListItemState();
}

class _ChildListItemState extends State<ChildListItem> {
  @override
  Widget build(BuildContext context) {
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
              Text(
                "${widget.products[widget.productPosition].productName} ${((shouldMarkForDeletion(widget.products[widget.productPosition])) ? "*" : "")}",
                style: const TextStyle(
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
                    "${widget.products[widget.productPosition].calories} Cals",
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5F554A),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  !widget.isEditSelected
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
                              widget.productsToDelete.add(widget.products[widget.productPosition]);
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
        (widget.productPosition == widget.products.length - 1)
            ? Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Color(0xFF94B69E)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 30.0,
                      ),
                      child: Text(
                        "${getAllProductsCalories(widget.products).toInt().toString()} Cals",
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
            : const SizedBox(),
      ],
    );
  }

  bool shouldMarkForDeletion(Product product) {
    return widget.productsToDelete.contains(product);
  }

  double getAllProductsCalories(List<Product> products) {
    double total = 0.0;
    for (int i = 0; i < widget.products.length; i++) {
      total += widget.products[i].calories;
    }
    return total;
  }
}
