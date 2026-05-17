// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentImpl _$$AppointmentImplFromJson(Map<String, dynamic> json) =>
    _$AppointmentImpl(
      id: json['id'] as String,
      visitorName: json['visitorName'] as String,
      visitorPhone: json['visitorPhone'] as String,
      visitorCompany: json['visitorCompany'] as String?,
      hostId: json['hostId'] as String,
      hostName: json['hostName'] as String,
      purpose: json['purpose'] as String,
      notes: json['notes'] as String?,
      scheduledAt: const RequiredTimestampConverter().fromJson(
        json['scheduledAt'],
      ),
      status: json['status'] as String? ?? 'scheduled',
      stationId: json['stationId'] as String?,
      createdBy: json['createdBy'] as String,
      createdAt: const RequiredTimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$AppointmentImplToJson(
  _$AppointmentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'visitorName': instance.visitorName,
  'visitorPhone': instance.visitorPhone,
  'visitorCompany': instance.visitorCompany,
  'hostId': instance.hostId,
  'hostName': instance.hostName,
  'purpose': instance.purpose,
  'notes': instance.notes,
  'scheduledAt': const RequiredTimestampConverter().toJson(
    instance.scheduledAt,
  ),
  'status': instance.status,
  'stationId': instance.stationId,
  'createdBy': instance.createdBy,
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
};
