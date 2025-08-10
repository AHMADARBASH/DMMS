// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/notifications/local_notification.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Features/auth/data/models/authenticated_user.dart';
import 'package:dmms/Features/main_pages/widgets/branch_admin/branch_admin_dashboard.dart';
import 'package:dmms/Features/main_pages/widgets/branch_admin/branch_admin_drawer.dart';
import 'package:dmms/Core/presentation/widgets/notifications_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';

import '../notifications/bloc/notifications_bloc.dart';

class BranchAdminHomePage extends StatefulWidget {
  final AuthenticatedUser user;
  static const String routeName = '/BranchAdminHomePage';
  const BranchAdminHomePage({super.key, required this.user});

  @override
  State<BranchAdminHomePage> createState() => _BranchAdminHomePageState();
}

class _BranchAdminHomePageState extends State<BranchAdminHomePage> {
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
      return androidInfo
          .id; // OR androidInfo.androidId (use androidId if you want the "SSAID")
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor; // Unique ID for iOS devices
    } else {
      return null;
    }
  }

  @override
  void initState() {
    context.read<NotificationsBloc>().add(NotificationsEvent.getAll());

    implementFCMToken().then((_) {
      getDeviceId().then((value) {
        deviceId = value;
      }).then((_) {
        BlocProvider.of<NotificationsBloc>(context)
            .add(NotificationsEvent.registerFCMToken(data: {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.dmms.tr(),
        ),
        actions: [
          NotificationsIcon(
            isNotificationEnable: widget.user.isNotificationEnabled,
          )
        ],
      ),
      drawer: BranchAdminDrawer(user: widget.user),
      body: BranchAdminDashboard(),
    );
  }
}
