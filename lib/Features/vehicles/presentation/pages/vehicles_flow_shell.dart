import 'package:dmms/Features/vehicles/bloc/vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehiclesFlowShell extends StatelessWidget {
  final Widget child;
  const VehiclesFlowShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VehiclesBloc>(
      create: (context) => VehiclesBloc()..add(VehiclesEvent.getVehicles()),
      child: child,
    );
  }
}
