import 'package:dmms/Features/departments/bloc/departments_bloc.dart';
import 'package:dmms/Features/employees/bloc/employees_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesFlowShell extends StatelessWidget {
  final Widget child;
  const EmployeesFlowShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<EmployeesBloc>(
        lazy: false,
        create: (context) => EmployeesBloc()..add(EmployeesEvent.getAll()),
      ),
      BlocProvider<DepartmentsBloc>(
        create: (context) => DepartmentsBloc(),
      ),
    ], child: child);
  }
}
