import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/users/data/data_providers/users_data_provider.dart';
import 'package:dmms/Features/users/data/models/user.dart';

class UsersRepository {
  final _dataProvider = serviceLocator.get<UsersDataProvider>();

  Future<List<User>> getAllUsers() async {
    final data = await _dataProvider.getAllUsers();

    return data.map((e) => User.fromJson(e)).toList();
  }

  Future<void> updateUserInfo({required Map<String, dynamic> data}) async {
    await _dataProvider.updateUserInfo(data: data);
  }

  Future<void> deActivateUser({required String userId}) async {
    await _dataProvider.deActivateUser(userId: userId);
  }

  Future<void> activateUser({required String userId}) async {
    await _dataProvider.activateUser(userId: userId);
  }

  Future<void> resetUserPassword({required Map<String, dynamic> data}) async {
    await _dataProvider.resetUserPassword(data: data);
  }
}
