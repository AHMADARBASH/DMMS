part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkLoginStatus() = CheckLoginStatus;
  const factory AuthEvent.login(Map<String, dynamic> credentials) = Login;
  const factory AuthEvent.logout() = Logout;
  const factory AuthEvent.createBranchAdmin(Map<String, dynamic> userData) =
      CreateBranchAdmin;
  const factory AuthEvent.createNormalUser(Map<String, dynamic> userData) =
      CreateNormalUser;
  const factory AuthEvent.updateUserData(AuthenticatedUser userData) =
      UpdateUserData;
}
