// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/notifications/local_notification.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/presentation/widgets/notifications_icon.dart';
import 'package:dmms/Features/main_pages/widgets/system_admin/system_admin_dashboard.dart';
import 'package:dmms/Features/main_pages/widgets/system_admin/system_admin_drawer.dart';
import 'package:dmms/Features/notifications/bloc/notifications_bloc.dart'
    as notifications;
import 'package:easy_localization/easy_localization.dart';

import 'package:permission_handler/permission_handler.dart';
import '../users/bloc/users_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/data/models/authenticated_user.dart';
import 'package:flutter/material.dart';

class SystemAdminHomePage extends StatefulWidget {
  final AuthenticatedUser user;
  static const String routeName = '/SystemAdminHomePage';
  const SystemAdminHomePage({super.key, required this.user});

  @override
  State<SystemAdminHomePage> createState() => _SystemAdminHomePageState();
}

class _SystemAdminHomePageState extends State<SystemAdminHomePage> {
  late String? fcmToken;
  late String? deviceId;
  Future<void> implementFCMToken() async {
    fcmToken = await LocalNotification.getFCMToken();
    if (fcmToken != null) {
      await CachedData.saveData(key: CacheStrings.fcmToken, data: fcmToken);
    }
  }

  Future<String?> getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    implementFCMToken().then((_) {
      getDeviceId().then((value) {
        deviceId = value;
      }).then((_) {
        BlocProvider.of<notifications.NotificationsBloc>(context)
            .add(notifications.NotificationsEvent.registerFCMToken(data: {
          "deviceId": deviceId,
          "fcmToken": fcmToken,
          "userID": widget.user.id,
          "platform": "android"
        }));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });

    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(
          create: (_) => UsersBloc()
            ..add(
              UsersEvent.getAllUsers(),
            ),
        ),
        BlocProvider<notifications.NotificationsBloc>(
          create: (_) => notifications.NotificationsBloc()
            ..add(
              notifications.NotificationsEvent.getAll(),
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.dmms.tr()),
          actions: [
            NotificationsIcon(
              isNotificationEnable: widget.user.isNotificationEnabled,
            ),
          ],
        ),
        drawer: Systemadmindrawer(user: widget.user),
        body: SystemAdminDashboard(),
      ),
    );
  }
}
