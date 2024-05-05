import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  const MenuCard(
      {Key? key,
      required this.title,
      required this.subTitle,
      this.onTap,
      required this.imagePath})
      : super(key: key);

  final String title;
  final String subTitle;
  final String imagePath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  imagePath,
                  width: 50,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
