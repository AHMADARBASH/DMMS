import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../Core/extensions/context_extenstions.dart';
import '../../../../Core/presentation/widgets/loading_widget.dart';
import '../../../../Core/presentation/widgets/system_logo_widget.dart';
import '../../../../Core/resources/app_strings.dart';
import '../../bloc/app_updates_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class CheckForUpdatesPage extends StatefulWidget {
  static const String routeName = '/CheckForUpdatesPage';
  const CheckForUpdatesPage({super.key});

  @override
  State<CheckForUpdatesPage> createState() => _CheckForUpdatesPageState();
}

class _CheckForUpdatesPageState extends State<CheckForUpdatesPage> {
  @override
  void initState() {
    context.read<AppUpdatesBloc>().add(AppUpdatesEvent.checkForUpdates());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUpdatesBloc, AppUpdatesState>(
      builder: (context, state) => Scaffold(
        backgroundColor: context.appColors.surface,
        body: SizedBox(
          width: context.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SystemLogoWidget(),
              SizedBox(
                height: 5.h,
              ),
              state is Loading
                  ? LoadingWidget(
                      color: context.appColors.primary,
                    )
                  : state is NotUpdate
                      ? Text(
                          AppStrings.aNewVersionOfTheApp.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : state is Error
                          ? Column(
                              children: [
                                Text(
                                  '${state.errorResponse.errorMessage} \n ${state.errorResponse.details}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<AppUpdatesBloc>()
                                        .add(AppUpdatesEvent.checkForUpdates());
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: context.appColors.primary,
                                  ),
                                )
                              ],
                            )
                          : LoadingWidget(
                              color: context.appColors.primary,
                            )
            ],
          ),
        ),
      ),
    );
  }
}
