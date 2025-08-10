part of 'app_updates_bloc.dart';

@freezed
abstract class AppUpdatesState with _$AppUpdatesState {
  const factory AppUpdatesState.initial() = Initial;
  const factory AppUpdatesState.loading() = Loading;
  const factory AppUpdatesState.error({required ErrorResponse errorResponse}) =
      Error;
  const factory AppUpdatesState.updated() = Updated;
  const factory AppUpdatesState.notUpdate() = NotUpdate;
}
