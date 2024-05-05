import 'package:flutter/material.dart';

ButtonStyle clockButton({String? time}) {
  ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: time != null && time.isNotEmpty ? Colors.green : Colors.black87,
    minimumSize: Size(88, 44),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
  );
  return elevatedButtonStyle;
}
