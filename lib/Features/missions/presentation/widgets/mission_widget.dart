import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_request_statuses.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/missions/data/models/mission.dart';
import 'package:dmms/Features/missions/presentation/pages/mission_details_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MissionWidget extends StatelessWidget {
  final Mission mission;
  const MissionWidget({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(0.95, -0.75),
      children: [
        Card(
          color: context.appColors.surface,
          elevation: AppSize.s0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.r12)),
          child: ListTile(
            title: Text(
              "From: ${mission.from} → To: ${mission.to}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Start Date: ${(mission.startDate)}"),
                Text("End Date: ${mission.endDate}"),
                Text("Mission Number: #${mission.serial_number}"),
              ],
            ),
            onTap: () {
              context.pushNamed(MissionDetailsPage.routeName, extra: mission);
            },
          ),
        ),
        Icon(
          Icons.circle,
          color: mission.statusId == AppRequestStatuses.active
              ? context.activeColor
              : mission.statusId == AppRequestStatuses.pending
                  ? context.pendingColor
                  : mission.statusId == AppRequestStatuses.completed
                      ? context.completedColor
                      : context.appColors.primary,
          size: AppSize.s15,
        ),
      ],
    );
  }
}
