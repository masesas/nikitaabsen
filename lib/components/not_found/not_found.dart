import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    Key? key,
    required this.image,
    required this.title,
    required this.content,
  }) : super(key: key);
  final Image image;
  final Text title;
  final Text content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: image,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: title,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: content,
          )
        ],
      ),
    );
  }
}
