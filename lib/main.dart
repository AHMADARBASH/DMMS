import 'package:dmms/Core/notifications/local_notification.dart';
import 'package:dmms/Core/presentation/widgets/loading_widget.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Core/theme/theme.dart';
import 'package:dmms/Features/app_updates/bloc/app_updates_bloc.dart';
import 'package:dmms/Features/notifications/bloc/notifications_bloc.dart';
import 'package:dmms/firebase_options.dart';
import 'package:dmms/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'Core/cache/cached_data.dart';
import 'Core/routes/routes.dart';
import 'Core/service_locator/service_locator.dart';
import 'Features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  serviceLocatorSetup();

  await CachedData.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalNotification.initializeNotificationSettings();
  configureEasyLoading();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
      fallbackLocale: Locale('en', 'US'),
      assetLoader: CodegenLoader(),
      child: const DMMS(),
    ),
  );
}

class DMMS extends StatelessWidget {
  const DMMS({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          lazy: false,
          create: (context) => serviceLocator.get<AuthBloc>()
            ..add(
              const AuthEvent.checkLoginStatus(),
            ),
        ),
        BlocProvider<NotificationsBloc>(
          lazy: false,
          create: (context) => NotificationsBloc(),
        ),
        BlocProvider<AppUpdatesBloc>(
          lazy: false,
          create: (_) => AppUpdatesBloc(),
        )
      ],
      child: Sizer(
        builder: (p0, p1, p2) => SafeArea(
          top: false,
          child: MaterialApp.router(
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            title: AppStrings.dmms.tr(),
            theme: theme,
            routerConfig: router,
            builder: (context, child) {
              return Directionality(
                textDirection: ui.TextDirection.ltr,
                child: EasyLoading.init()(context, child),
              );
            },
          ),
        ),
      ),
    );
  }
}

configureEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.black
    ..backgroundColor = Color(0xFFFFFFFF)
    ..indicatorColor = Color(0xFFED1C24)
    ..maskColor = Colors.black38
    ..radius = AppRadius.r12
    ..indicatorWidget = SizedBox(
      width: AppSize.s70,
      height: AppSize.s70,
      child: LoadingWidget(
        color: Color(0xFFED1C24),
      ),
    )
    ..textColor = Colors.white;
}
