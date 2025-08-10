import 'package:dmms/Core/cache/cached_data.dart';
import 'package:dmms/Core/env/env.dart';
import 'package:dmms/Core/network/api_helper.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';

class VehiclesDataProvider {
  final _apiHelper = serviceLocator.get<ApiHelper>();

  Future<List<dynamic>> getVehicleBrands() async {
    List<dynamic> data = await _apiHelper.get(
        URL: '${Env.baseUrl}/VehicleBrands/GetAll',
        token: CachedData.getData(key: CacheStrings.token));
    return data;
  }

  Future<List<dynamic>> getVehicleTypes() async {
    List<dynamic> data = await _apiHelper.get(
        URL: '${Env.baseUrl}/VehiclesTypes/GetAll',
        token: CachedData.getData(key: CacheStrings.token));
    return data;
  }

  Future<dynamic> addVehicleBrand(Map<String, dynamic> data) async {
    final brand = await _apiHelper.post(
      URL: '${Env.baseUrl}/VehicleBrands/Add',
      body: data,
      token: CachedData.getData(key: CacheStrings.token),
    );
    return brand;
  }

  Future<dynamic> addVehicleType(Map<String, dynamic> data) async {
    final brand = await _apiHelper.post(
      URL: '${Env.baseUrl}/VehiclesTypes/Add',
      body: data,
      token: CachedData.getData(key: CacheStrings.token),
    );
    return brand;
  }

  Future<List<dynamic>> getVehicles() async {
    List<dynamic> vehiles = await _apiHelper.get(
      URL: '${Env.baseUrl}/Vehicles/GetAll',
      token: CachedData.getData(key: CacheStrings.token),
    );
    return vehiles;
  }

  Future<void> updateVehicle({required Map<String, dynamic> data}) async {
    await _apiHelper.put(
      URL: '${Env.baseUrl}/Vehicles/Update',
      body: data,
      token: CachedData.getData(key: CacheStrings.token),
    );
  }

  Future<void> activateVehicle({required String vehicleId}) async {
    await _apiHelper.put(
      URL: '${Env.baseUrl}/Vehicles/Activate/$vehicleId',
      token: CachedData.getData(key: CacheStrings.token),
    );
  }

  Future<void> deActivateVehicle({required String vehicleId}) async {
    await _apiHelper.put(
      URL: '${Env.baseUrl}/Vehicles/Deactivate/$vehicleId',
      token: CachedData.getData(key: CacheStrings.token),
    );
  }

  Future<void> addVehicle({required Map<String, dynamic> data}) async {
    await _apiHelper.post(
      URL: '${Env.baseUrl}/Vehicles/Add',
      body: data,
      token: CachedData.getData(key: CacheStrings.token),
    );
  }
}
