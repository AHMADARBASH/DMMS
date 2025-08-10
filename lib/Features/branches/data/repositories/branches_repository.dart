import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/branches/data/data_providers/branches_data_provider.dart';
import 'package:dmms/Features/branches/data/models/branch.dart';

class BranchesRepository {
  var branchesDataProvider = serviceLocator.get<BranchesDataProvider>();

  Future<List<Branch>> getAllBranches() async {
    List<dynamic> data = await branchesDataProvider.getAllBranches();
    List<Branch> branches = data.map((e) => Branch.fromJson(e)).toList();
    return branches;
  }

  Future<Branch> getById({required String branchId}) async {
    var data = await branchesDataProvider.getById(branchId: branchId);
    return Branch.fromJson(data);
  }
}
