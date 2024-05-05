import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/models/workday.dart';
import 'package:nikitaabsen/screens/edit_schedule/edit_schedule.controller.dart';

import '../../components/button/basic_button.dart';
import '../../utils/constants.dart';

class EditWorkdaysPage extends StatelessWidget {
  const EditWorkdaysPage({
    Key? key,
    required this.workdayList,
  }) : super(key: key);

  final List<Workday>? workdayList;

  @override
  Widget build(BuildContext context) {
    final states = Get.put(EditScheduleController());

    return Obx(
      () => states.loading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text('Jumlah Hari'),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: BasicButton(
                  basicText: 'Terapkan',
                  color: mainColor,
                  onPressed: states.handleSubmitWorkday,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: Column(
                children: <Widget>[
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Senin',
                    choiceItems: states.options,
                    placeholder: 'Pilih Shift',
                    selectedValue: states.selectedSenin(workdayList),
                    onChange: (state) =>
                        states.onSelectedSenin(state.value, '1'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Selasa',
                    choiceItems: states.options,
                    placeholder: 'Pilih Shift',
                    selectedValue: states.selectedSelasa(workdayList),
                    onChange: (state) =>
                        states.onSelectedSelasa(state.value, '2'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Rabu',
                    choiceItems: states.options,
                    placeholder: 'Pilih Shift',
                    selectedValue: states.selectedRabu(workdayList),
                    onChange: (state) =>
                        states.onSelectedRabu(state.value, '3'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Kamis',
                    choiceItems: states.options,
                    placeholder: 'Pilih Shift',
                    selectedValue: states.selectedKamis(workdayList),
                    onChange: (state) =>
                        states.onSelectedKamis(state.value, '4'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Jumat',
                    choiceItems: states.options,
                    placeholder: 'Pilih Shift',
                    selectedValue: states.selectedJumat(workdayList),
                    onChange: (state) =>
                        states.onSelectedJumat(state.value, '5'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Sabtu',
                    choiceItems: states.options,
                    placeholder: 'Pilih Shift',
                    selectedValue: states.selectedSabtu(workdayList),
                    onChange: (state) =>
                        states.onSelectedSabtu(state.value, '6'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Minggu',
                    choiceItems: states.options,
                    placeholder: 'Pilih Shift',
                    selectedValue: states.selectedMinggu(workdayList),
                    onChange: (state) =>
                        states.onSelectedMinggu(state.value, '7'),
                  ),
                ],
              ),
            ),
    );
  }
}
