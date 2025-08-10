import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_status.g.dart';
part 'request_status.freezed.dart';

@freezed
abstract class RequestStatus with _$RequestStatus {
  const factory RequestStatus({
    required String id,
    required String status,
  }) = _RequestStatus;
  factory RequestStatus.fromJson(Map<String, Object?> json) =>
      _$RequestStatusFromJson(json);
}
