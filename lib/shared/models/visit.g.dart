// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitImpl _$$VisitImplFromJson(Map<String, dynamic> json) => _$VisitImpl(
  id: json['id'] as String,
  visitorId: json['visitorId'] as String?,
  visitorName: json['visitorName'] as String,
  visitorPhone: json['visitorPhone'] as String,
  visitorCompany: json['visitorCompany'] as String?,
  hostId: json['hostId'] as String,
  hostName: json['hostName'] as String,
  purpose: json['purpose'] as String,
  notes: json['notes'] as String?,
  expectedDuration: json['expectedDuration'] as String?,
  stationId: json['stationId'] as String,
  checkInTime: const RequiredTimestampConverter().fromJson(json['checkInTime']),
  checkOutTime: const TimestampConverter().fromJson(json['checkOutTime']),
  status: json['status'] as String? ?? 'active',
  signatureB64: json['signatureB64'] as String?,
  badgeQrData: json['badgeQrData'] as String?,
  appointmentId: json['appointmentId'] as String?,
  createdBy: json['createdBy'] as String,
  createdAt: const RequiredTimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$VisitImplToJson(
  _$VisitImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'visitorId': instance.visitorId,
  'visitorName': instance.visitorName,
  'visitorPhone': instance.visitorPhone,
  'visitorCompany': instance.visitorCompany,
  'hostId': instance.hostId,
  'hostName': instance.hostName,
  'purpose': instance.purpose,
  'notes': instance.notes,
  'expectedDuration': instance.expectedDuration,
  'stationId': instance.stationId,
  'checkInTime': const RequiredTimestampConverter().toJson(
    instance.checkInTime,
  ),
  'checkOutTime': const TimestampConverter().toJson(instance.checkOutTime),
  'status': instance.status,
  'signatureB64': instance.signatureB64,
  'badgeQrData': instance.badgeQrData,
  'appointmentId': instance.appointmentId,
  'createdBy': instance.createdBy,
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
};
