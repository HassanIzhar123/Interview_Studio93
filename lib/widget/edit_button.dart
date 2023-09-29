import 'package:flutter/material.dart';

class EditButton extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color texColor;
  final Color borderColor;
  final double borderWidth;
  final Function() onTap;

  const EditButton(
      {super.key,
        required this.text,
        required this.fontSize,
        required this.fontWeight,
        required this.texColor,
        required this.borderColor,
        required  this.borderWidth,
      required this.onTap});

  @override
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
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
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            color: widget.texColor,
          ),
        ),
      ),
    );
  }
}
