// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return _Appointment.fromJson(json);
}

/// @nodoc
mixin _$Appointment {
  String get id => throw _privateConstructorUsedError;
  String get visitorName => throw _privateConstructorUsedError;
  String get visitorPhone => throw _privateConstructorUsedError;
  String? get visitorCompany => throw _privateConstructorUsedError;
  String get hostId => throw _privateConstructorUsedError;
  String get hostName => throw _privateConstructorUsedError;
  String get purpose => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @RequiredTimestampConverter()
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'scheduled' | 'checked_in' | 'cancelled' | 'no_show'
  String? get stationId => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  @RequiredTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Appointment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentCopyWith<Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentCopyWith<$Res> {
  factory $AppointmentCopyWith(
    Appointment value,
    $Res Function(Appointment) then,
  ) = _$AppointmentCopyWithImpl<$Res, Appointment>;
  @useResult
  $Res call({
    String id,
    String visitorName,
    String visitorPhone,
    String? visitorCompany,
    String hostId,
    String hostName,
    String purpose,
    String? notes,
    @RequiredTimestampConverter() DateTime scheduledAt,
    String status,
    String? stationId,
    String createdBy,
    @RequiredTimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$AppointmentCopyWithImpl<$Res, $Val extends Appointment>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? visitorName = null,
    Object? visitorPhone = null,
    Object? visitorCompany = freezed,
    Object? hostId = null,
    Object? hostName = null,
    Object? purpose = null,
    Object? notes = freezed,
    Object? scheduledAt = null,
    Object? status = null,
    Object? stationId = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            visitorName: null == visitorName
                ? _value.visitorName
                : visitorName // ignore: cast_nullable_to_non_nullable
                      as String,
            visitorPhone: null == visitorPhone
                ? _value.visitorPhone
                : visitorPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            visitorCompany: freezed == visitorCompany
                ? _value.visitorCompany
                : visitorCompany // ignore: cast_nullable_to_non_nullable
                      as String?,
            hostId: null == hostId
                ? _value.hostId
                : hostId // ignore: cast_nullable_to_non_nullable
                      as String,
            hostName: null == hostName
                ? _value.hostName
                : hostName // ignore: cast_nullable_to_non_nullable
                      as String,
            purpose: null == purpose
                ? _value.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            scheduledAt: null == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            stationId: freezed == stationId
                ? _value.stationId
                : stationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppointmentImplCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$AppointmentImplCopyWith(
    _$AppointmentImpl value,
    $Res Function(_$AppointmentImpl) then,
  ) = __$$AppointmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String visitorName,
    String visitorPhone,
    String? visitorCompany,
    String hostId,
    String hostName,
    String purpose,
    String? notes,
    @RequiredTimestampConverter() DateTime scheduledAt,
    String status,
    String? stationId,
    String createdBy,
    @RequiredTimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$AppointmentImplCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$AppointmentImpl>
    implements _$$AppointmentImplCopyWith<$Res> {
  __$$AppointmentImplCopyWithImpl(
    _$AppointmentImpl _value,
    $Res Function(_$AppointmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? visitorName = null,
    Object? visitorPhone = null,
    Object? visitorCompany = freezed,
    Object? hostId = null,
    Object? hostName = null,
    Object? purpose = null,
    Object? notes = freezed,
    Object? scheduledAt = null,
    Object? status = null,
    Object? stationId = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$AppointmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        visitorName: null == visitorName
            ? _value.visitorName
            : visitorName // ignore: cast_nullable_to_non_nullable
                  as String,
        visitorPhone: null == visitorPhone
            ? _value.visitorPhone
            : visitorPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        visitorCompany: freezed == visitorCompany
            ? _value.visitorCompany
            : visitorCompany // ignore: cast_nullable_to_non_nullable
                  as String?,
        hostId: null == hostId
            ? _value.hostId
            : hostId // ignore: cast_nullable_to_non_nullable
                  as String,
        hostName: null == hostName
            ? _value.hostName
            : hostName // ignore: cast_nullable_to_non_nullable
                  as String,
        purpose: null == purpose
            ? _value.purpose
            : purpose // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        scheduledAt: null == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        stationId: freezed == stationId
            ? _value.stationId
            : stationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentImpl implements _Appointment {
  const _$AppointmentImpl({
    required this.id,
    required this.visitorName,
    required this.visitorPhone,
    this.visitorCompany,
    required this.hostId,
    required this.hostName,
    required this.purpose,
    this.notes,
    @RequiredTimestampConverter() required this.scheduledAt,
    this.status = 'scheduled',
    this.stationId,
    required this.createdBy,
    @RequiredTimestampConverter() required this.createdAt,
  });

  factory _$AppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentImplFromJson(json);

  @override
  final String id;
  @override
  final String visitorName;
  @override
  final String visitorPhone;
  @override
  final String? visitorCompany;
  @override
  final String hostId;
  @override
  final String hostName;
  @override
  final String purpose;
  @override
  final String? notes;
  @override
  @RequiredTimestampConverter()
  final DateTime scheduledAt;
  @override
  @JsonKey()
  final String status;
  // 'scheduled' | 'checked_in' | 'cancelled' | 'no_show'
  @override
  final String? stationId;
  @override
  final String createdBy;
  @override
  @RequiredTimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'Appointment(id: $id, visitorName: $visitorName, visitorPhone: $visitorPhone, visitorCompany: $visitorCompany, hostId: $hostId, hostName: $hostName, purpose: $purpose, notes: $notes, scheduledAt: $scheduledAt, status: $status, stationId: $stationId, createdBy: $createdBy, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visitorName, visitorName) ||
                other.visitorName == visitorName) &&
            (identical(other.visitorPhone, visitorPhone) ||
                other.visitorPhone == visitorPhone) &&
            (identical(other.visitorCompany, visitorCompany) ||
                other.visitorCompany == visitorCompany) &&
            (identical(other.hostId, hostId) || other.hostId == hostId) &&
            (identical(other.hostName, hostName) ||
                other.hostName == hostName) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.stationId, stationId) ||
                other.stationId == stationId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    visitorName,
    visitorPhone,
    visitorCompany,
    hostId,
    hostName,
    purpose,
    notes,
    scheduledAt,
    status,
    stationId,
    createdBy,
    createdAt,
  );

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      __$$AppointmentImplCopyWithImpl<_$AppointmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentImplToJson(this);
  }
}

abstract class _Appointment implements Appointment {
  const factory _Appointment({
    required final String id,
    required final String visitorName,
    required final String visitorPhone,
    final String? visitorCompany,
    required final String hostId,
    required final String hostName,
    required final String purpose,
    final String? notes,
    @RequiredTimestampConverter() required final DateTime scheduledAt,
    final String status,
    final String? stationId,
    required final String createdBy,
    @RequiredTimestampConverter() required final DateTime createdAt,
  }) = _$AppointmentImpl;

  factory _Appointment.fromJson(Map<String, dynamic> json) =
      _$AppointmentImpl.fromJson;

  @override
  String get id;
  @override
  String get visitorName;
  @override
  String get visitorPhone;
  @override
  String? get visitorCompany;
  @override
  String get hostId;
  @override
  String get hostName;
  @override
  String get purpose;
  @override
  String? get notes;
  @override
  @RequiredTimestampConverter()
  DateTime get scheduledAt;
  @override
  String get status; // 'scheduled' | 'checked_in' | 'cancelled' | 'no_show'
  @override
  String? get stationId;
  @override
  String get createdBy;
  @override
  @RequiredTimestampConverter()
  DateTime get createdAt;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
