// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StationImpl _$$StationImplFromJson(Map<String, dynamic> json) =>
    _$StationImpl(
      id: json['id'] as String,
      branchName: json['branchName'] as String?,
      floor: json['floor'] as String?,
      position: json['position'] as String?,
      configuredAt: const TimestampConverter().fromJson(json['configuredAt']),
      isOnline: json['isOnline'] as bool? ?? false,
    );

Map<String, dynamic> _$$StationImplToJson(_$StationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branchName': instance.branchName,
      'floor': instance.floor,
      'position': instance.position,
      'configuredAt': const TimestampConverter().toJson(instance.configuredAt),
      'isOnline': instance.isOnline,
    };

_$ActiveSessionImpl _$$ActiveSessionImplFromJson(Map<String, dynamic> json) =>
    _$ActiveSessionImpl(
      screen: json['screen'] as String? ?? 'idle',
      status: json['status'] as String?,
      visitorName: json['visitorName'] as String?,
      hostName: json['hostName'] as String?,
      hostId: json['hostId'] as String?,
      purpose: json['purpose'] as String?,
      notes: json['notes'] as String?,
      timestamp: const TimestampConverter().fromJson(json['timestamp']),
      signatureB64: json['signatureB64'] as String?,
      badgePayload: json['badgePayload'] == null
          ? null
          : BadgePayload.fromJson(json['badgePayload'] as Map<String, dynamic>),
      receptionistUid: json['receptionistUid'] as String?,
      sessionId: json['sessionId'] as String?,
      assignedFloor: json['assignedFloor'] as String?,
    );

Map<String, dynamic> _$$ActiveSessionImplToJson(_$ActiveSessionImpl instance) =>
    <String, dynamic>{
      'screen': instance.screen,
      'status': instance.status,
      'visitorName': instance.visitorName,
      'hostName': instance.hostName,
      'hostId': instance.hostId,
      'purpose': instance.purpose,
      'notes': instance.notes,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
      'signatureB64': instance.signatureB64,
      'badgePayload': instance.badgePayload?.toJson(),
      'receptionistUid': instance.receptionistUid,
      'sessionId': instance.sessionId,
      'assignedFloor': instance.assignedFloor,
    };

_$BadgePayloadImpl _$$BadgePayloadImplFromJson(Map<String, dynamic> json) =>
    _$BadgePayloadImpl(
      visitId: json['visitId'] as String,
      visitorName: json['visitorName'] as String,
      hostName: json['hostName'] as String,
      purpose: json['purpose'] as String,
      checkInTime: const RequiredTimestampConverter().fromJson(
        json['checkInTime'],
      ),
      qrData: json['qrData'] as String,
    );

Map<String, dynamic> _$$BadgePayloadImplToJson(_$BadgePayloadImpl instance) =>
    <String, dynamic>{
      'visitId': instance.visitId,
      'visitorName': instance.visitorName,
      'hostName': instance.hostName,
      'purpose': instance.purpose,
      'checkInTime': const RequiredTimestampConverter().toJson(
        instance.checkInTime,
      ),
      'qrData': instance.qrData,
    };
