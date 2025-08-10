import 'package:dmms/Core/presentation/widgets/back_button_widget.dart';
import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:dmms/Core/presentation/widgets/error_refresh_widget.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/resources/app_validators.dart';
import 'package:dmms/Core/resources/app_values.dart';
import 'package:dmms/Features/missions/bloc/missions_bloc.dart';
import 'package:dmms/Features/missions/presentation/widgets/mission_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:easy_localization/easy_localization.dart';

class MissionsPage extends StatelessWidget {
  static const String routeName = '/MissionsPage';
  MissionsPage({super.key});
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonWidget(),
        title: CustomTextField(
            lable: AppStrings.searchInVehicles.tr(),
            controller: searchController,
            hasSuffix: false,
            action: TextInputAction.search,
            onChanged: (value) {
              context
                  .read<MissionsBloc>()
                  .add(MissionsEvent.search(query: searchController.text));
            },
            validator: AppValidators.notRequired),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p5,
        ),
        child: BlocConsumer<MissionsBloc, MissionsState>(
          listener: (context, state) {
            if (state.isLoading) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
            }
          },
          builder: (context, state) {
            if (state.errorResponse != null) {
              return ErrorRefreshWidget(
                text:
                    '${state.errorResponse!.errorMessage} \n ${state.errorResponse!.details}',
                onPressed: () {
                  context.read<MissionsBloc>().add(MissionsEvent.getAll());
                },
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<MissionsBloc>().add(MissionsEvent.getAll());
                },
                child: ListView.builder(
                  itemCount: state.missions.length,
                  itemBuilder: (context, index) {
                    var mission = state.missions[index];
                    return MissionWidget(mission: mission);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
