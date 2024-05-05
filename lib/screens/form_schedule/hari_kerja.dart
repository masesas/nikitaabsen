import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/button/basic_button.dart';
import '../../utils/constants.dart';
import 'hari_kerja.controller.dart';

class Harikerja extends StatelessWidget {
  const Harikerja({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final states = Get.put(HariKerjaController());

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
                    selectedValue: states.selectedSenin(),
                    onChange: (state) =>
                        states.onSelectedSenin(state.value, '1'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Selasa',
                    choiceItems: states.options,
                    selectedValue: states.selectedSelasa(),
                    onChange: (state) =>
                        states.onSelectedSelasa(state.value, '2'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Rabu',
                    choiceItems: states.options,
                    selectedValue: states.selectedRabu(),
                    onChange: (state) =>
                        states.onSelectedRabu(state.value, '3'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Kamis',
                    choiceItems: states.options,
                    selectedValue: states.selectedKamis(),
                    onChange: (state) =>
                        states.onSelectedKamis(state.value, '4'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Jumat',
                    choiceItems: states.options,
                    selectedValue: states.selectedJumat(),
                    onChange: (state) =>
                        states.onSelectedJumat(state.value, '5'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Sabtu',
                    choiceItems: states.options,
                    selectedValue: states.selectedSabtu(),
                    onChange: (state) =>
                        states.onSelectedSabtu(state.value, '6'),
                  ),
                  const Divider(),
                  SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceDivider: true,
                    title: 'Minggu',
                    choiceItems: states.options,
                    selectedValue: states.selectedMinggu(),
                    onChange: (state) =>
                        states.onSelectedMinggu(state.value, '7'),
                  ),
                ],
              ),
            ),
    );
  }
}
