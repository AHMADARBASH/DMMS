part of 'users_bloc.dart';

@freezed
sealed class UsersEvent with _$UsersEvent {
  const factory UsersEvent.getAllUsers() = GetAllUsers;
  const factory UsersEvent.updateUserInfo(
      {required Map<String, dynamic> data}) = UpdateUserInfo;
  const factory UsersEvent.deActivateUser({required String userId}) =
      DeActivateUser;
  const factory UsersEvent.activateUser({required String userId}) =
      ActivateUser;
  const factory UsersEvent.resetUserPassword(
      {required Map<String, dynamic> data}) = ResetUserPassword;
  const factory UsersEvent.resetFlags() = ResetFlags;
  const factory UsersEvent.search({required String query}) = Search;
}
