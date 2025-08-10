import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/mission_types/data/data_providers/mission_types_data_provider.dart';
import 'package:dmms/Features/mission_types/data/models/mission_type.dart';

class MissionTypesRepository {
  final _dataProvier = serviceLocator.get<MissionTypesDataProvider>();

  Future<List<MissionType>> getAll() async {
    final List<dynamic> data = await _dataProvier.getAll();
    return data.map((m) => MissionType.fromJson(m)).toList();
  }

  Future<MissionType> getById({required String id}) async {
    final data = await _dataProvier.getById(id: id);
    return MissionType.fromJson(data);
  }

  Future<MissionType> add({required Map<String, dynamic> data}) async {
    final type = await _dataProvier.add(data: data);
    return MissionType.fromJson(type);
  }

  Future<MissionType> update({required Map<String, dynamic> data}) async {
    final type = await _dataProvier.update(data: data);
    return MissionType.fromJson(type);
  }
}
