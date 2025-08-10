import 'package:dmms/Features/vehicles/data/models/fuel_type.dart';

abstract class AppFuelTypes {
  static const benzene =
      FuelType(id: 'e5592e02-921d-4232-b80d-2569433937d8', name: 'Benzene');
  static const diesel =
      FuelType(id: 'b835bfc3-7227-4601-b655-e1cd3d66ef7d', name: 'Diesel');

  static const fuelTypes = <FuelType>[benzene, diesel];
}
