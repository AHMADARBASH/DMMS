part of 'missions_bloc.dart';

@freezed
abstract class MissionsEvent with _$MissionsEvent {
  const factory MissionsEvent.getAll() = GetAll;
  const factory MissionsEvent.getById({required String missionId}) = GetById;
  const factory MissionsEvent.add({required Map<String, dynamic> data}) = Add;
  const factory MissionsEvent.setActive({required String missionId}) =
      SetActive;
  const factory MissionsEvent.update({required Map<String, dynamic> data}) =
      Update;
  const factory MissionsEvent.setCanceled(
      {required Map<String, dynamic> data}) = SetCanceled;
  const factory MissionsEvent.setComplete(
      {required Map<String, dynamic> data}) = SetComplete;
  const factory MissionsEvent.search({required String query}) = Search;
}
