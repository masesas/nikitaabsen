// ignore_for_file: prefer_const_declarations, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/activity.model.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';

class BasicListTile extends StatelessWidget {
  const BasicListTile({Key? key, required this.activity, this.onTap})
      : super(key: key);

  final Map<String, dynamic> activity;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final String activityDate =
        AppUtils.basicDateFormatter(activity['att_datetime']);
    final String timeIn = AppUtils.getTimeFromDate(activity['att_datetime']);
    final String timeOut = '';
    final String appStatus = '';
    final String status = activity['status'];
    final String isApprovedApproval = '';
    final String notes = '';

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      leading: (activity['att_selfie']?.isNotEmpty ?? false)
          ? CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(
                AppUtils.getUrl(
                    "/res/file?inline=true&file=${activity['att_selfie']}"),
              ),
            )
          : CircleAvatar(
              radius: 30,
              backgroundColor: mainColor,
              child: Text(
                AppUtils.getInitials(AppUtils.getUser().fullname ?? 'No Name'),
                style: TextStyle(fontSize: 20),
              ),
            ),
      title: Text(AppUtils.getUser().fullname ?? 'User'),
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
          if (activity['status'] != 'IZIN' && activity['status'] != 'CUTI')
            Text("Jam: $timeIn"),
          Text(
            "Status: $status",
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
