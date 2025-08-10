import 'package:dmms/Core/presentation/widgets/custom_text_field.dart';
import 'package:dmms/Core/resources/app_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../Core/presentation/widgets/add_button_widget.dart';
import '../../../../Core/presentation/widgets/back_button_widget.dart';
import '../../../../Core/presentation/widgets/error_refresh_widget.dart';
import '../../../../Core/presentation/widgets/show_snack_bar.dart';
import '../../../../Core/resources/app_strings.dart';
import '../../../../Core/resources/app_values.dart';
import '../../bloc/vehicles_bloc.dart';
import '../widgets/vehicle_widget.dart';
import 'add_vehicle_page.dart';

class VehiclesPage extends StatefulWidget {
  static const String routeName = '/VehiclesPage';
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  @override
  void initState() {
    context.read<VehiclesBloc>().add(VehiclesEvent.getVehicles());
    super.initState();
  }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextField(
            lable: AppStrings.searchInVehicles.tr(),
            controller: searchController,
            hasSuffix: false,
            action: TextInputAction.search,
            onChanged: (value) {
              context
                  .read<VehiclesBloc>()
                  .add(VehiclesEvent.search(query: searchController.text));
            },
            validator: AppValidators.notRequired),
        leading: BackButtonWidget(),
        actions: [
          AddButtonWidget(onPressed: () {
            context.pushNamed(AddVehiclePage.routeName);
          }),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
        child: BlocConsumer<VehiclesBloc, VehiclesState>(
          listener: (context, state) {
            if (state.isLoading) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
            }
            if (state.successMessage != null && !state.isLoading) {
              showSnackBar(context, state.successMessage!);
              context.read<VehiclesBloc>().add(VehiclesEvent.resetFlags());
            }
          },
          builder: (context, state) {
            if (state.errorResponse != null) {
              return ErrorRefreshWidget(
                text:
                    '${state.errorResponse!.errorMessage} \n ${state.errorResponse!.details}',
                onPressed: () {
                  context
                      .read<VehiclesBloc>()
                      .add(VehiclesEvent.getBrandsAndTypes());
                },
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<VehiclesBloc>()
                      .add(VehiclesEvent.getBrandsAndTypes());
                },
                child: ListView.builder(
                  itemCount: state.vehicles.length,
                  itemBuilder: (context, index) {
                    var vehicle = state.vehicles[index];
                    return VehicleWidget(
                      vehicle: vehicle,
                    );
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
