import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/extensions/context_extenstions.dart';
import '../../../../Core/presentation/widgets/back_button_widget.dart';
import '../../../../Core/presentation/widgets/error_refresh_widget.dart';
import '../../../../Core/presentation/widgets/loading_widget.dart';
import '../../../../Core/resources/app_strings.dart';
import '../../../../Core/resources/app_values.dart';
import '../../bloc/notifications_bloc.dart';
import '../widgets/filter_toggle.dart';
import '../widgets/notifications_widget.dart';

class NotificationsPage extends StatelessWidget {
  static const String routeName = '/NotificationsPage';
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationsBloc>().add(NotificationsEvent.getAll());
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.notifications.tr()),
        leading: BackButtonWidget(),
        actions: [],
      ),
      body: Column(
        children: [
          MessageFilterToggle(),
          SizedBox(
            height: AppSize.s10,
          ),
          BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
              if (state.errorResponse != null) {
                return Expanded(
                  child: ErrorRefreshWidget(
                      onPressed: () {
                        context
                            .read<NotificationsBloc>()
                            .add(NotificationsEvent.getAll());
                      },
                      text:
                          '${state.errorResponse!.errorMessage} \n ${state.errorResponse!.details}'),
                );
              }
              if (state.isLoading) {
                return Expanded(
                  child: Center(
                    child: LoadingWidget(
                      color: context.appColors.primary,
                    ),
                  ),
                );
              }
              if (state.notifications.isNotEmpty) {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context
                                .read<NotificationsBloc>()
                                .add(NotificationsEvent.getAll());
                          },
                          child: ListView.builder(
                            itemCount: state.notifications.length,
                            itemBuilder: (context, index) {
                              var noti = state.notifications[index];
                              return NotificationsWidget(noti: noti);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(AppStrings.noMessages.tr())],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
