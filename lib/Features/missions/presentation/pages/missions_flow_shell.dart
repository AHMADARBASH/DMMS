import 'package:dmms/Features/missions/bloc/missions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionsFlowShell extends StatelessWidget {
  final Widget child;

  const MissionsFlowShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MissionsBloc>(
      create: (context) => MissionsBloc()..add(MissionsEvent.getAll()),
      child: child,
    );
  }
}
