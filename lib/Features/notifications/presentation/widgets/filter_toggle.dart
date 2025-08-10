import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/resources/app_durations.dart';
import 'package:dmms/Core/resources/app_enums.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/notifications/bloc/notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageFilterToggle extends StatefulWidget {
  const MessageFilterToggle({
    super.key,
  });

  @override
  State<MessageFilterToggle> createState() => _MessageFilterToggleState();
}

class _MessageFilterToggleState extends State<MessageFilterToggle> {
  @override
  Widget build(BuildContext context) {
    final filters = NotificationsFilter.values;
    final labels = ["All", "Read", "Unread"];
    final index = filters.indexOf(context.watch<NotificationsBloc>().selected);

    return Container(
      width: AppSize.s300,
      height: AppSize.s50,
      padding: const EdgeInsets.all(AppPadding.p4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r12),
        color: context.appColors.surface,
      ),
      child: Stack(
        children: [
          // Sliding background
          AnimatedAlign(
            duration: AppDurations.d200ms,
            curve: Curves.easeInOut,
            alignment: [
              Alignment.centerLeft,
              Alignment.center,
              Alignment.centerRight,
            ][index],
            child: Container(
              width: AppSize.s100,
              height: double.infinity,
              decoration: BoxDecoration(
                color: context.appColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.r10),
              ),
            ),
          ),

          // Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: filters.map((filter) {
              final isSelected =
                  context.watch<NotificationsBloc>().selected == filter;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.read<NotificationsBloc>().add(
                        NotificationsEvent.filterNotifications(filter: filter));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: AppDurations.d200ms,
                        style: TextStyle(
                          color: isSelected
                              ? context.appColors.onPrimary
                              : context.appColors.onSurface,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        child: Text(labels[filters.indexOf(filter)]),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
