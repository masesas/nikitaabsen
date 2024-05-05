import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/activity.model.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';

class BasicListTileOvertome extends StatelessWidget {
  const BasicListTileOvertome({Key? key, required this.activity, this.onTap})
      : super(key: key);

  final Activity activity;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final String activityDate =
        AppUtils.basicDateFormatter(activity.createdAt!);

    final String ovtimeDate =
        AppUtils.basicDateFormatter(activity.overtimeDateTo);
    final String ovTime = AppUtils.getTimeFromDate(activity.overtimeDateTo);
    final String ovFrom =
        AppUtils.getTimeFromDate(activity.overtimeRequestDate);
    final String oVnote = AppUtils.overtimenote(activity.overtimeNote);
    final String appStat = AppUtils.overtimetatus(activity.isApprovedOvertime);
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
        ovtimeDate,
        style: const TextStyle(color: Colors.grey),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Text("Dari: $ovFrom"),
          Text("Sampai: $ovTime"),
          Text("Alasan: $oVnote"),
          const SizedBox(height: 5),
          Text(appStat,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.redAccent))
        ],
      ),
    );
  }
}
