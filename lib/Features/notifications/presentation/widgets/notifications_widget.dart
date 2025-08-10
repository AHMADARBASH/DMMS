import 'package:dmms/Core/extensions/context_extenstions.dart';
import 'package:dmms/Core/presentation/widgets/app_button.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/notifications/bloc/notifications_bloc.dart';
import 'package:dmms/Features/notifications/data/models/api_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationsWidget extends StatelessWidget {
  final APINotification noti;
  const NotificationsWidget({super.key, required this.noti});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (!noti.isRead) {
              context
                  .read<NotificationsBloc>()
                  .add(ReadNotification(notificationId: noti.id));
            }
            showDialog(
                context: context,
                builder: (_) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: AppPadding.p10),
                          padding: EdgeInsets.all(AppPadding.p12),
                          decoration: BoxDecoration(
                            color: context.appColors.surface,
                            borderRadius: BorderRadius.circular(AppRadius.r12),
                          ),
                          height: AppSize.s300,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    noti.title,
                                    style: context.textTheme.titleLarge!
                                        .copyWith(
                                            color: context.appColors.primary),
                                  ),
                                ],
                              ),
                              Row(
                                children: [Expanded(child: Text(noti.content))],
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      context.read<NotificationsBloc>().add(
                                          NotificationsEvent.unReadNotification(
                                              notificationId: noti.id));
                                      context.pop();
                                    },
                                    child: Text('mark as unread'),
                                  ),
                                  SizedBox(
                                    width: AppSize.s16,
                                  ),
                                  AppButton(text: 'ok', onTap: context.pop),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ));
          },
          child: Column(
            children: [
              SizedBox(
                height: AppSize.s120,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p10, vertical: AppPadding.p5),
                  decoration: BoxDecoration(
                    color: noti.isRead
                        ? context.appColors.onPrimary
                        : context.appColors.primaryFixed,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${noti.title}\n',
                          style: TextStyle(
                            color: context.appColors.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          noti.content,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
          color: context.appColors.outlineVariant,
        )
      ],
    );
  }
}
