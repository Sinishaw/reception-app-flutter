// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Visit _$VisitFromJson(Map<String, dynamic> json) {
  return _Visit.fromJson(json);
}

/// @nodoc
mixin _$Visit {
  String get id => throw _privateConstructorUsedError;
  String? get visitorId => throw _privateConstructorUsedError;
  String get visitorName => throw _privateConstructorUsedError;
  String get visitorPhone => throw _privateConstructorUsedError;
  String? get visitorCompany => throw _privateConstructorUsedError;
  String get hostId => throw _privateConstructorUsedError;
  String get hostName => throw _privateConstructorUsedError;
  String get purpose => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get expectedDuration => throw _privateConstructorUsedError;
  String get stationId => throw _privateConstructorUsedError;
  @RequiredTimestampConverter()
  DateTime get checkInTime => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get checkOutTime => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'active' | 'checked_out'
  String? get signatureB64 => throw _privateConstructorUsedError;
  String? get badgeQrData => throw _privateConstructorUsedError;
  String? get appointmentId => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  @RequiredTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Visit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VisitCopyWith<Visit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitCopyWith<$Res> {
  factory $VisitCopyWith(Visit value, $Res Function(Visit) then) =
      _$VisitCopyWithImpl<$Res, Visit>;
  @useResult
  $Res call({
    String id,
    String? visitorId,
    String visitorName,
    String visitorPhone,
    String? visitorCompany,
    String hostId,
    String hostName,
    String purpose,
    String? notes,
    String? expectedDuration,
    String stationId,
    @RequiredTimestampConverter() DateTime checkInTime,
    @TimestampConverter() DateTime? checkOutTime,
    String status,
    String? signatureB64,
    String? badgeQrData,
    String? appointmentId,
    String createdBy,
    @RequiredTimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$VisitCopyWithImpl<$Res, $Val extends Visit>
    implements $VisitCopyWith<$Res> {
  _$VisitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? visitorId = freezed,
    Object? visitorName = null,
    Object? visitorPhone = null,
    Object? visitorCompany = freezed,
    Object? hostId = null,
    Object? hostName = null,
    Object? purpose = null,
    Object? notes = freezed,
    Object? expectedDuration = freezed,
    Object? stationId = null,
    Object? checkInTime = null,
    Object? checkOutTime = freezed,
    Object? status = null,
    Object? signatureB64 = freezed,
    Object? badgeQrData = freezed,
    Object? appointmentId = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            visitorId: freezed == visitorId
                ? _value.visitorId
                : visitorId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            expectedDuration: freezed == expectedDuration
                ? _value.expectedDuration
                : expectedDuration // ignore: cast_nullable_to_non_nullable
                      as String?,
            stationId: null == stationId
                ? _value.stationId
                : stationId // ignore: cast_nullable_to_non_nullable
                      as String,
            checkInTime: null == checkInTime
                ? _value.checkInTime
                : checkInTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            checkOutTime: freezed == checkOutTime
                ? _value.checkOutTime
                : checkOutTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            signatureB64: freezed == signatureB64
                ? _value.signatureB64
                : signatureB64 // ignore: cast_nullable_to_non_nullable
                      as String?,
            badgeQrData: freezed == badgeQrData
                ? _value.badgeQrData
                : badgeQrData // ignore: cast_nullable_to_non_nullable
                      as String?,
            appointmentId: freezed == appointmentId
                ? _value.appointmentId
                : appointmentId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$VisitImplCopyWith<$Res> implements $VisitCopyWith<$Res> {
  factory _$$VisitImplCopyWith(
    _$VisitImpl value,
    $Res Function(_$VisitImpl) then,
  ) = __$$VisitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? visitorId,
    String visitorName,
    String visitorPhone,
    String? visitorCompany,
    String hostId,
    String hostName,
    String purpose,
    String? notes,
    String? expectedDuration,
    String stationId,
    @RequiredTimestampConverter() DateTime checkInTime,
    @TimestampConverter() DateTime? checkOutTime,
    String status,
    String? signatureB64,
    String? badgeQrData,
    String? appointmentId,
    String createdBy,
    @RequiredTimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$VisitImplCopyWithImpl<$Res>
    extends _$VisitCopyWithImpl<$Res, _$VisitImpl>
    implements _$$VisitImplCopyWith<$Res> {
  __$$VisitImplCopyWithImpl(
    _$VisitImpl _value,
    $Res Function(_$VisitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? visitorId = freezed,
    Object? visitorName = null,
    Object? visitorPhone = null,
    Object? visitorCompany = freezed,
    Object? hostId = null,
    Object? hostName = null,
    Object? purpose = null,
    Object? notes = freezed,
    Object? expectedDuration = freezed,
    Object? stationId = null,
    Object? checkInTime = null,
    Object? checkOutTime = freezed,
    Object? status = null,
    Object? signatureB64 = freezed,
    Object? badgeQrData = freezed,
    Object? appointmentId = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$VisitImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        visitorId: freezed == visitorId
            ? _value.visitorId
            : visitorId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        expectedDuration: freezed == expectedDuration
            ? _value.expectedDuration
            : expectedDuration // ignore: cast_nullable_to_non_nullable
                  as String?,
        stationId: null == stationId
            ? _value.stationId
            : stationId // ignore: cast_nullable_to_non_nullable
                  as String,
        checkInTime: null == checkInTime
            ? _value.checkInTime
            : checkInTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        checkOutTime: freezed == checkOutTime
            ? _value.checkOutTime
            : checkOutTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        signatureB64: freezed == signatureB64
            ? _value.signatureB64
            : signatureB64 // ignore: cast_nullable_to_non_nullable
                  as String?,
        badgeQrData: freezed == badgeQrData
            ? _value.badgeQrData
            : badgeQrData // ignore: cast_nullable_to_non_nullable
                  as String?,
        appointmentId: freezed == appointmentId
            ? _value.appointmentId
            : appointmentId // ignore: cast_nullable_to_non_nullable
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

@JsonSerializable(explicitToJson: true)
class _$VisitImpl implements _Visit {
  const _$VisitImpl({
    required this.id,
    this.visitorId,
    required this.visitorName,
    required this.visitorPhone,
    this.visitorCompany,
    required this.hostId,
    required this.hostName,
    required this.purpose,
    this.notes,
    this.expectedDuration,
    required this.stationId,
    @RequiredTimestampConverter() required this.checkInTime,
    @TimestampConverter() this.checkOutTime,
    this.status = 'active',
    this.signatureB64,
    this.badgeQrData,
    this.appointmentId,
    required this.createdBy,
    @RequiredTimestampConverter() required this.createdAt,
  });

  factory _$VisitImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitImplFromJson(json);

  @override
  final String id;
  @override
  final String? visitorId;
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
  final String? expectedDuration;
  @override
  final String stationId;
  @override
  @RequiredTimestampConverter()
  final DateTime checkInTime;
  @override
  @TimestampConverter()
  final DateTime? checkOutTime;
  @override
  @JsonKey()
  final String status;
  // 'active' | 'checked_out'
  @override
  final String? signatureB64;
  @override
  final String? badgeQrData;
  @override
  final String? appointmentId;
  @override
  final String createdBy;
  @override
  @RequiredTimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'Visit(id: $id, visitorId: $visitorId, visitorName: $visitorName, visitorPhone: $visitorPhone, visitorCompany: $visitorCompany, hostId: $hostId, hostName: $hostName, purpose: $purpose, notes: $notes, expectedDuration: $expectedDuration, stationId: $stationId, checkInTime: $checkInTime, checkOutTime: $checkOutTime, status: $status, signatureB64: $signatureB64, badgeQrData: $badgeQrData, appointmentId: $appointmentId, createdBy: $createdBy, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visitorId, visitorId) ||
                other.visitorId == visitorId) &&
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
            (identical(other.expectedDuration, expectedDuration) ||
                other.expectedDuration == expectedDuration) &&
            (identical(other.stationId, stationId) ||
                other.stationId == stationId) &&
            (identical(other.checkInTime, checkInTime) ||
                other.checkInTime == checkInTime) &&
            (identical(other.checkOutTime, checkOutTime) ||
                other.checkOutTime == checkOutTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.signatureB64, signatureB64) ||
                other.signatureB64 == signatureB64) &&
            (identical(other.badgeQrData, badgeQrData) ||
                other.badgeQrData == badgeQrData) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    visitorId,
    visitorName,
    visitorPhone,
    visitorCompany,
    hostId,
    hostName,
    purpose,
    notes,
    expectedDuration,
    stationId,
    checkInTime,
    checkOutTime,
    status,
    signatureB64,
    badgeQrData,
    appointmentId,
    createdBy,
    createdAt,
  ]);

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitImplCopyWith<_$VisitImpl> get copyWith =>
      __$$VisitImplCopyWithImpl<_$VisitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitImplToJson(this);
  }
}

abstract class _Visit implements Visit {
  const factory _Visit({
    required final String id,
    final String? visitorId,
    required final String visitorName,
    required final String visitorPhone,
    final String? visitorCompany,
    required final String hostId,
    required final String hostName,
    required final String purpose,
    final String? notes,
    final String? expectedDuration,
    required final String stationId,
    @RequiredTimestampConverter() required final DateTime checkInTime,
    @TimestampConverter() final DateTime? checkOutTime,
    final String status,
    final String? signatureB64,
    final String? badgeQrData,
    final String? appointmentId,
    required final String createdBy,
    @RequiredTimestampConverter() required final DateTime createdAt,
  }) = _$VisitImpl;

  factory _Visit.fromJson(Map<String, dynamic> json) = _$VisitImpl.fromJson;

  @override
  String get id;
  @override
  String? get visitorId;
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
  String? get expectedDuration;
  @override
  String get stationId;
  @override
  @RequiredTimestampConverter()
  DateTime get checkInTime;
  @override
  @TimestampConverter()
  DateTime? get checkOutTime;
  @override
  String get status; // 'active' | 'checked_out'
  @override
  String? get signatureB64;
  @override
  String? get badgeQrData;
  @override
  String? get appointmentId;
  @override
  String get createdBy;
  @override
  @RequiredTimestampConverter()
  DateTime get createdAt;

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VisitImplCopyWith<_$VisitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
