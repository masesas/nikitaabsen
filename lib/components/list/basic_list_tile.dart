import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/activity.model.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';

class BasicListTile extends StatelessWidget {
  const BasicListTile({Key? key, required this.activity, this.onTap})
      : super(key: key);

  final Activity activity;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final String activityDate =
        AppUtils.basicDateFormatter(activity.createdAt!);
    final String timeIn = AppUtils.getTimeFromDate(activity.timeIn);
    final String timeOut = AppUtils.getTimeFromDate(activity.timeOut);
    final String appStatus =
        AppUtils.mapActivityStatusAll(activity.status!, activity);
    final String status = AppUtils.mapActivityStatus(activity.status!);
    final String isApprovedApproval =
        AppUtils.getIsApprovedAbsen(activity.isApprovedIn);
    final String notes = AppUtils.mapActivityNotes(activity.status!, activity);

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
        activityDate,
        style: const TextStyle(color: Colors.grey),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Text("Masuk: $timeIn"),
          Text("Keluar: $timeOut"),
          Text(
            "Status: $status",
            // textAlign: TextAlign.end,
          ),
          Text(
            "Notes: $notes",
            // textAlign: TextAlign.end,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            appStatus,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.redAccent),
          )
        ],
      ),
    );
  }
}
