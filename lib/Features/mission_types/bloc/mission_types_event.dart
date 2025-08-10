part of 'mission_types_bloc.dart';

@freezed
class MissionTypesEvent with _$MissionTypesEvent {
  const factory MissionTypesEvent.getAll() = GetAll;
  const factory MissionTypesEvent.getById({required String id}) = GetById;
  const factory MissionTypesEvent.add({required Map<String, dynamic> data}) =
      Add;
  const factory MissionTypesEvent.update({required Map<String, dynamic> data}) =
      Update;
  const factory MissionTypesEvent.resetFlags() = ResetFlags;
}
