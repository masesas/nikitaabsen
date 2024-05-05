import 'package:flutter/material.dart';
import 'package:nikitaabsen/models/user.model.dart';

class BasicListTileUser extends StatefulWidget {
  const BasicListTileUser({Key? key, required this.userss}) : super(key: key);

  final User userss;

  @override
  State<BasicListTileUser> createState() => _BasicListTileUserState();
}

class _BasicListTileUserState extends State<BasicListTileUser> {
  List userUp = <User>[];
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      title: Text(widget.userss.fullname ?? 'User'),
    );
  }
}
