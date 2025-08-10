import 'dart:convert';

import 'package:dmms/Core/resources/app_strings.dart';

import '../../../../Core/cache/cached_data.dart';
import '../../../../Core/service_locator/service_locator.dart';
import '../data_providers/auth_data_provider.dart';
import '../models/authenticated_user.dart';

class AuthRepo {
  final _dataProvider = serviceLocator.get<AuthDataProvider>();

  Future<AuthenticatedUser> login(Map<String, dynamic> credentials) async {
    var response = await _dataProvider.login(credentials);
    await CachedData.saveData(
        key: CacheStrings.token, data: response[CacheStrings.token]);
    await CachedData.saveData(
        key: CacheStrings.user, data: json.encode(response[CacheStrings.user]));
    return AuthenticatedUser.fromJson(response[CacheStrings.user]);
  }

  Future<void> createBranchAdmin(Map<String, dynamic> userData) async {
    await _dataProvider.createBranchAdmin(userData: userData);
  }

  Future<void> createNormalUser(Map<String, dynamic> userData) async {
    await _dataProvider.createNormalUser(userData: userData);
  }
}
