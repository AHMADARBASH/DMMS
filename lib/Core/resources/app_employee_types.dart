import 'package:dmms/Features/employees/data/models/employee_type.dart';

abstract class AppEmployeeTypes {
  static const EmployeeType driver = EmployeeType(
    id: '76bc7ccf-18ab-4623-8434-1cabb223ce4e',
    name: 'Driver',
  );
  static const EmployeeType staff = EmployeeType(
    id: 'fac0f64d-8ccf-405b-aa10-537741f3ddd5',
    name: 'Staff',
  );
  static const EmployeeType volunteer = EmployeeType(
      id: 'c25d0656-7615-4ae9-adfc-7dcbfdc958e1', name: 'Volunteer');

  static const employeeTypes = [driver, staff, volunteer];
}
