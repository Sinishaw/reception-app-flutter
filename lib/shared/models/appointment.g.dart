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
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      status: json['status'] as String? ?? 'scheduled',
      stationId: json['stationId'] as String?,
      createdBy: json['createdBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AppointmentImplToJson(_$AppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitorName': instance.visitorName,
      'visitorPhone': instance.visitorPhone,
      'visitorCompany': instance.visitorCompany,
      'hostId': instance.hostId,
      'hostName': instance.hostName,
      'purpose': instance.purpose,
      'notes': instance.notes,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'status': instance.status,
      'stationId': instance.stationId,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
    };
