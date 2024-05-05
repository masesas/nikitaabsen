import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'workdays.controller.dart';

class WorkdasyPage extends StatelessWidget {
  const WorkdasyPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final states = Get.put(WorkdaysController());

    return Column(
      children: <Widget>[
        SmartSelect<String>.single(
          modalType: S2ModalType.popupDialog,
          choiceDivider: true,
          title: 'Senin',
          choiceItems: states.options,
          selectedValue: states.valueSenin.value,
          onChange: (state) => states.onSelectedWorkday(state.value, '1'),
        ),
        const Divider(),
        SmartSelect<String>.single(
          modalType: S2ModalType.popupDialog,
          choiceDivider: true,
          title: 'Selasa',
          choiceItems: states.options,
          selectedValue: states.valueSelasa.value,
          onChange: (state) => states.onSelectedWorkday(state.value, '2'),
        ),
        const Divider(),
        SmartSelect<String>.single(
          modalType: S2ModalType.popupDialog,
          choiceDivider: true,
          title: 'Rabu',
          choiceItems: states.options,
          selectedValue: states.valueRabu.value,
          onChange: (state) => states.onSelectedWorkday(state.value, '3'),
        ),
        const Divider(),
        SmartSelect<String>.single(
          modalType: S2ModalType.popupDialog,
          choiceDivider: true,
          title: 'Kamis',
          choiceItems: states.options,
          selectedValue: states.valueKamis.value,
          onChange: (state) => states.onSelectedWorkday(state.value, '4'),
        ),
        const Divider(),
        SmartSelect<String>.single(
          modalType: S2ModalType.popupDialog,
          choiceDivider: true,
          title: 'Jumat',
          choiceItems: states.options,
          selectedValue: states.valueJumat.value,
          onChange: (state) => states.onSelectedWorkday(state.value, '5'),
        ),
        const Divider(),
        SmartSelect<String>.single(
          modalType: S2ModalType.popupDialog,
          choiceDivider: true,
          title: 'Sabtu',
          choiceItems: states.options,
          selectedValue: states.valueSabtu.value,
          onChange: (state) => states.onSelectedWorkday(state.value, '6'),
        ),
        const Divider(),
        SmartSelect<String>.single(
          modalType: S2ModalType.popupDialog,
          choiceDivider: true,
          title: 'Minggu',
          choiceItems: states.options,
          selectedValue: states.valueMinggu.value,
          onChange: (state) => states.onSelectedWorkday(state.value, '7'),
        ),
      ],
    );
  }
}
