part of 'app_updates_bloc.dart';

@freezed
abstract class AppUpdatesEvent with _$AppUpdatesEvent {
  const factory AppUpdatesEvent.checkForUpdates() = CheckForUpdates;
}
