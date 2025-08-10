part of 'auth_bloc.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.error({required ErrorResponse errorResponse}) = Error;
  const factory AuthState.userCreated() = UserCreated;
  const factory AuthState.authenticated({required AuthenticatedUser user}) =
      Authenticated;
  const factory AuthState.loggedOut() = LoggedOut;
}
