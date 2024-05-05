import 'package:flutter/material.dart';

import '../../../models/shifting.model.dart';
import '../../../utils/app_utils.dart';

class ShiftingListTile extends StatelessWidget {
  const ShiftingListTile({
    Key? key,
    required this.shifting,
    required this.onPressed,
  }) : super(key: key);

  final Shifting shifting;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var hasShifting = AppUtils.hasShiftingTime(shifting.from, shifting.to);
    var shiftFrom = hasShifting ? AppUtils.formatTime(shifting.from!) : null;
    var shiftTo = hasShifting ? AppUtils.formatTime(shifting.to!) : null;

    var subtitle = hasShifting ? "$shiftFrom - $shiftTo" : "-";

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      // minVerticalPadding: 0,
      // dense: true,
      title: Text(shifting.name!),
      subtitle: Text(subtitle),
      trailing: IconButton(
        icon: const Icon(Icons.edit_note),
        onPressed: onPressed,
      ),
    );
  }
}
