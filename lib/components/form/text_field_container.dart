import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final bool validate;
  const TextFieldContainer({
    Key? key,
    required this.child,
    this.validate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF0277BD)),
        boxShadow: [
          BoxShadow(
            color: validate ? Colors.red : Colors.white,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
