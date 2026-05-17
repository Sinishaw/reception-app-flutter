import 'package:freezed_annotation/freezed_annotation.dart';
import 'timestamp_converter.dart';

part 'station.freezed.dart';
part 'station.g.dart';

@freezed
class Station with _$Station {
  const factory Station({
    required String id,
    String? branchName,
    String? floor,
    String? position,
    @TimestampConverter() DateTime? configuredAt,
    @Default(false) bool isOnline,
  }) = _Station;

  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);
}

@freezed
class ActiveSession with _$ActiveSession {
  @JsonSerializable(explicitToJson: true)
  const factory ActiveSession({
    @Default('idle') String screen, // 'idle' | 'summary' | 'badge'
    String? status, // 'pending_signature' | 'signed' | 'complete'
    String? visitorName,
    String? hostName,
    String? hostId,
    String? purpose,
    String? notes,
    @TimestampConverter() DateTime? timestamp,
    String? signatureB64,
    BadgePayload? badgePayload,
    String? receptionistUid,
  }) = _ActiveSession;

  factory ActiveSession.fromJson(Map<String, dynamic> json) => _$ActiveSessionFromJson(json);
}

@freezed
class BadgePayload with _$BadgePayload {
  @JsonSerializable(explicitToJson: true)
  const factory BadgePayload({
    required String visitId,
    required String visitorName,
    required String hostName,
    required String purpose,
    @RequiredTimestampConverter() required DateTime checkInTime,
    required String qrData,
  }) = _BadgePayload;

  factory BadgePayload.fromJson(Map<String, dynamic> json) => _$BadgePayloadFromJson(json);
}
