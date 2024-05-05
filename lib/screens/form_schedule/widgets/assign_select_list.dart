import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';

import '../../../models/user.model.dart';

class AssignSelectList extends StatelessWidget {
  const AssignSelectList({
    Key? key,
    required this.user,
    required this.scheduleOptions,
    required this.onChange,
    required this.selectedValue,
  }) : super(key: key);

  final User user;
  final List<S2Choice<String>> scheduleOptions;
  final Function(S2SingleSelected<String>)? onChange;
  final String selectedValue;

  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.single(
      modalType: S2ModalType.bottomSheet,
      placeholder: 'Pilih',
      modalTitle: 'Pilih Jadwal Kerja',
      choiceDivider: true,
      title: user.fullname,
      choiceItems: scheduleOptions,
      onChange: onChange,
      selectedValue: selectedValue,
    );
  }
}
