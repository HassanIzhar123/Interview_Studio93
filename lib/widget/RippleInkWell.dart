import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RippleInkWell extends StatefulWidget {
  final Widget child;
  final Function() onTap;
  final Color containerColor;

  const RippleInkWell({super.key, required this.containerColor, required this.child, required this.onTap});

  @override
  State<RippleInkWell> createState() => _RippleInkWellState();
}

class _RippleInkWellState extends State<RippleInkWell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.containerColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.onTap();
          },
          child: widget.child,
        ),
      ),
    );
  }
}
