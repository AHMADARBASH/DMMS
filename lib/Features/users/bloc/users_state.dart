part of 'users_bloc.dart';

@freezed
sealed class UsersState with _$UsersState {
  const factory UsersState({
    @Default(false) bool isLoading,
    @Default([]) List<User> users,
    ErrorResponse? errorResponse,
    @Default(false) bool passwordReseted,
    @Default(false) bool userUpdated,
    @Default(false) bool userActivated,
    @Default(false) bool userDeActivated,
  }) = _UsersState;
}
