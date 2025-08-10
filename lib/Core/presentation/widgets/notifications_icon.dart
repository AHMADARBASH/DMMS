import 'package:dmms/Features/notifications/bloc/notifications_bloc.dart';
import 'package:dmms/Features/notifications/presentation/pages/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationsIcon extends StatefulWidget {
  final bool isNotificationEnable;
  const NotificationsIcon({required this.isNotificationEnable, super.key});

  @override
  State<NotificationsIcon> createState() => _NotificationsIconState();
}

class _NotificationsIconState extends State<NotificationsIcon> {
  @override
  Widget build(BuildContext context) {
    return Badge(
      alignment: Alignment(0.3, -0.5),
      isLabelVisible: widget.isNotificationEnable &&
          context
              .watch<NotificationsBloc>()
              .state
              .notifications
              .any((n) => !n.isRead),
      label: Text(
        context
            .read<NotificationsBloc>()
            .state
            .notifications
            .where((e) => e.isRead == false)
            .length
            .toString(),
      ),
      child: IconButton(
        onPressed: () {
          context.pushNamed(NotificationsPage.routeName);
        },
        icon: Icon(widget.isNotificationEnable
            ? Icons.notifications
            : Icons.notifications_off_rounded),
      ),
    );
  }
}
