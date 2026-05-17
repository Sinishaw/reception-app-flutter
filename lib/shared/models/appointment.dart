import 'package:freezed_annotation/freezed_annotation.dart';
import 'timestamp_converter.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    required String id,
    required String visitorName,
    required String visitorPhone,
    String? visitorCompany,
    required String hostId,
    required String hostName,
    required String purpose,
    String? notes,
    @RequiredTimestampConverter() required DateTime scheduledAt,
    @Default('scheduled') String status, // 'scheduled' | 'checked_in' | 'cancelled' | 'no_show'
    String? stationId,
    required String createdBy,
    @RequiredTimestampConverter() required DateTime createdAt,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);
}
