import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/activity.model.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';

class BasicListTileLeave extends StatelessWidget {
  const BasicListTileLeave({Key? key, required this.activity, this.onTap})
      : super(key: key);

  final Activity activity;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final String activityDate =
        AppUtils.basicDateFormatter(activity.createdAt!);

    final String Pfrom =
        AppUtils.basicDateFormatterNoDay(activity.leavePeriodFrom);
    final String createdAt = AppUtils.basicDateFormatter(activity.createdAt);
    final String Pto = AppUtils.basicDateFormatterNoDay(activity.leavePeriodTo);
    final String Pnote = AppUtils.leaveNote(activity.leaveNote);
    final String appStat = AppUtils.overtimetatus(activity.isApprovedLeave);
    final String status = AppUtils.mapActivityStatus(activity.status!);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      leading: (activity.checkInPhoto?.isNotEmpty ?? false)
          ? CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(
                AppUtils.getUrl(activity.checkInPhoto!),
              ),
            )
          : CircleAvatar(
              radius: 30,
              backgroundColor: mainColor,
              child: Text(
                AppUtils.getInitials(activity.user?.fullname ?? 'No Name'),
                style: TextStyle(fontSize: 20),
              ),
            ),
      title: Text(activity.user?.fullname ?? 'User'),
      isThreeLine: true,
      trailing: Text(
        createdAt,
        style: const TextStyle(color: Colors.grey),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Text("Mulai: $Pfrom"),
          Text("Akhir: $Pto"),
          Text(
            "Notes: $Pnote",
          ),
          const SizedBox(
            height: 5,
          ),
          Text(appStat,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.redAccent))
        ],
      ),
    );
  }
}
