import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/missions/data/data_providers/missions_data_provider.dart';
import 'package:dmms/Features/missions/data/models/mission.dart';

class MissionsRepository {
  final _dataProvider = serviceLocator.get<MissionsDataProvider>();

  Future<List<Mission>> getAll() async {
    final data = await _dataProvider.getAll();
    return data.map((m) => Mission.fromJson(m)).toList();
  }

  Future<Mission> getById({required String missionId}) async {
    final data = await _dataProvider.getById(missionId: missionId);
    return Mission.fromJson(data);
  }

  Future<void> add({required Map<String, dynamic> data}) async {
    await _dataProvider.add(data: data);
  }

  Future<void> setActive({required String missionId}) async {
    await _dataProvider.setActive(missionId: missionId);
  }

  Future<void> update({required Map<String, dynamic> data}) async {
    await _dataProvider.update(data: data);
  }

  Future<void> setCanceled({required Map<String, dynamic> data}) async {
    await _dataProvider.setCanceled(data: data);
  }

  Future<void> setComplete({required Map<String, dynamic> data}) async {
    await _dataProvider.setComplete(data: data);
  }
}
