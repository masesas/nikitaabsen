import 'package:flutter/material.dart';
import 'package:nikitaabsen/utils/constants.dart';

class BasicButton extends StatelessWidget {
  const BasicButton(
      {Key? key,
      required this.onPressed,
      this.loadingText = 'Memproses',
      this.isLoading = false,
      required this.basicText,
      required this.color})
      : super(key: key);

  final Function()? onPressed;
  final String loadingText;
  final String basicText;
  final bool isLoading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: Colors.indigo.shade300,
      onPressed: onPressed,
      color: color,
      elevation: 0,
      height: 50,
      minWidth: 400,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: isLoading
          ? Text(
              loadingText,
              style: const TextStyle(fontSize: 17, color: Colors.white),
            )
          : Text(
              basicText,
              style: const TextStyle(fontSize: 17),
            ),
    );
  }
}
