// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffImpl _$$StaffImplFromJson(Map<String, dynamic> json) => _$StaffImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  department: json['department'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  fcmToken: json['fcmToken'] as String?,
  notifyOnArrival: json['notifyOnArrival'] as bool? ?? true,
  notifyOnCheckout: json['notifyOnCheckout'] as bool? ?? false,
  notifyBeforeAppointment: json['notifyBeforeAppointment'] as bool? ?? true,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$$StaffImplToJson(_$StaffImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'department': instance.department,
      'email': instance.email,
      'phone': instance.phone,
      'fcmToken': instance.fcmToken,
      'notifyOnArrival': instance.notifyOnArrival,
      'notifyOnCheckout': instance.notifyOnCheckout,
      'notifyBeforeAppointment': instance.notifyBeforeAppointment,
      'isActive': instance.isActive,
    };
