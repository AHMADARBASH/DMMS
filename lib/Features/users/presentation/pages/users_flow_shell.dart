import 'package:dmms/Features/users/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersFlowShell extends StatelessWidget {
  final Widget child;
  const UsersFlowShell({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersBloc>(
      create: (_) => UsersBloc()..add(UsersEvent.getAllUsers()),
      child: child,
    );
  }
}
