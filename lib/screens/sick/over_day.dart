import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nikitaabsen/components/form/izin_form.dart';
import 'package:nikitaabsen/screens/sick/sick_form.dart';
import 'package:nikitaabsen/utils/constants.dart';
import 'package:intl/intl.dart';

class OverOneDay extends StatefulWidget {
  const OverOneDay({Key? key}) : super(key: key);

  @override
  State<OverOneDay> createState() => _OverOneDayState();
}

class _OverOneDayState extends State<OverOneDay> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: IzinSakitFrom(),
    );
  }
}
