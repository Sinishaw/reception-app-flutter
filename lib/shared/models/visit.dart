// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'timestamp_converter.dart';

part 'visit.freezed.dart';
part 'visit.g.dart';

@freezed
class Visit with _$Visit {
  @JsonSerializable(explicitToJson: true)
  const factory Visit({
    required String id,
    String? visitorId,
    required String visitorName,
    required String visitorPhone,
    String? visitorCompany,
    required String hostId,
    required String hostName,
    required String purpose,
    String? notes,
    String? expectedDuration,
    required String stationId,
    @RequiredTimestampConverter() required DateTime checkInTime,
    @TimestampConverter() DateTime? checkOutTime,
    @Default('active') String status, // 'active' | 'checked_out'
    String? signatureB64,
    String? badgeQrData,
    String? appointmentId,
    required String createdBy,
    @RequiredTimestampConverter() required DateTime createdAt,
  }) = _Visit;

  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);
}
