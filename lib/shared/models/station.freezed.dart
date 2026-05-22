// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Station _$StationFromJson(Map<String, dynamic> json) {
  return _Station.fromJson(json);
}

/// @nodoc
mixin _$Station {
  String get id => throw _privateConstructorUsedError;
  String? get branchName => throw _privateConstructorUsedError;
  String? get floor => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get configuredAt => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;

  /// Serializes this Station to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StationCopyWith<Station> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationCopyWith<$Res> {
  factory $StationCopyWith(Station value, $Res Function(Station) then) =
      _$StationCopyWithImpl<$Res, Station>;
  @useResult
  $Res call({
    String id,
    String? branchName,
    String? floor,
    String? position,
    @TimestampConverter() DateTime? configuredAt,
    bool isOnline,
  });
}

/// @nodoc
class _$StationCopyWithImpl<$Res, $Val extends Station>
    implements $StationCopyWith<$Res> {
  _$StationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branchName = freezed,
    Object? floor = freezed,
    Object? position = freezed,
    Object? configuredAt = freezed,
    Object? isOnline = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            branchName: freezed == branchName
                ? _value.branchName
                : branchName // ignore: cast_nullable_to_non_nullable
                      as String?,
            floor: freezed == floor
                ? _value.floor
                : floor // ignore: cast_nullable_to_non_nullable
                      as String?,
            position: freezed == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as String?,
            configuredAt: freezed == configuredAt
                ? _value.configuredAt
                : configuredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isOnline: null == isOnline
                ? _value.isOnline
                : isOnline // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StationImplCopyWith<$Res> implements $StationCopyWith<$Res> {
  factory _$$StationImplCopyWith(
    _$StationImpl value,
    $Res Function(_$StationImpl) then,
  ) = __$$StationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? branchName,
    String? floor,
    String? position,
    @TimestampConverter() DateTime? configuredAt,
    bool isOnline,
  });
}

/// @nodoc
class __$$StationImplCopyWithImpl<$Res>
    extends _$StationCopyWithImpl<$Res, _$StationImpl>
    implements _$$StationImplCopyWith<$Res> {
  __$$StationImplCopyWithImpl(
    _$StationImpl _value,
    $Res Function(_$StationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branchName = freezed,
    Object? floor = freezed,
    Object? position = freezed,
    Object? configuredAt = freezed,
    Object? isOnline = null,
  }) {
    return _then(
      _$StationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        branchName: freezed == branchName
            ? _value.branchName
            : branchName // ignore: cast_nullable_to_non_nullable
                  as String?,
        floor: freezed == floor
            ? _value.floor
            : floor // ignore: cast_nullable_to_non_nullable
                  as String?,
        position: freezed == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as String?,
        configuredAt: freezed == configuredAt
            ? _value.configuredAt
            : configuredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isOnline: null == isOnline
            ? _value.isOnline
            : isOnline // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StationImpl implements _Station {
  const _$StationImpl({
    required this.id,
    this.branchName,
    this.floor,
    this.position,
    @TimestampConverter() this.configuredAt,
    this.isOnline = false,
  });

  factory _$StationImpl.fromJson(Map<String, dynamic> json) =>
      _$$StationImplFromJson(json);

  @override
  final String id;
  @override
  final String? branchName;
  @override
  final String? floor;
  @override
  final String? position;
  @override
  @TimestampConverter()
  final DateTime? configuredAt;
  @override
  @JsonKey()
  final bool isOnline;

  @override
  String toString() {
    return 'Station(id: $id, branchName: $branchName, floor: $floor, position: $position, configuredAt: $configuredAt, isOnline: $isOnline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.branchName, branchName) ||
                other.branchName == branchName) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.configuredAt, configuredAt) ||
                other.configuredAt == configuredAt) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    branchName,
    floor,
    position,
    configuredAt,
    isOnline,
  );

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StationImplCopyWith<_$StationImpl> get copyWith =>
      __$$StationImplCopyWithImpl<_$StationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StationImplToJson(this);
  }
}

abstract class _Station implements Station {
  const factory _Station({
    required final String id,
    final String? branchName,
    final String? floor,
    final String? position,
    @TimestampConverter() final DateTime? configuredAt,
    final bool isOnline,
  }) = _$StationImpl;

  factory _Station.fromJson(Map<String, dynamic> json) = _$StationImpl.fromJson;

  @override
  String get id;
  @override
  String? get branchName;
  @override
  String? get floor;
  @override
  String? get position;
  @override
  @TimestampConverter()
  DateTime? get configuredAt;
  @override
  bool get isOnline;

  /// Create a copy of Station
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StationImplCopyWith<_$StationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActiveSession _$ActiveSessionFromJson(Map<String, dynamic> json) {
  return _ActiveSession.fromJson(json);
}

/// @nodoc
mixin _$ActiveSession {
  String get screen =>
      throw _privateConstructorUsedError; // 'idle' | 'summary' | 'badge'
  String? get status =>
      throw _privateConstructorUsedError; // 'pending_signature' | 'signed' | 'complete'
  String? get visitorName => throw _privateConstructorUsedError;
  String? get hostName => throw _privateConstructorUsedError;
  String? get hostId => throw _privateConstructorUsedError;
  String? get purpose => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  String? get signatureB64 => throw _privateConstructorUsedError;
  BadgePayload? get badgePayload => throw _privateConstructorUsedError;
  String? get receptionistUid => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  String? get assignedFloor => throw _privateConstructorUsedError;

  /// Serializes this ActiveSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActiveSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveSessionCopyWith<ActiveSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveSessionCopyWith<$Res> {
  factory $ActiveSessionCopyWith(
    ActiveSession value,
    $Res Function(ActiveSession) then,
  ) = _$ActiveSessionCopyWithImpl<$Res, ActiveSession>;
  @useResult
  $Res call({
    String screen,
    String? status,
    String? visitorName,
    String? hostName,
    String? hostId,
    String? purpose,
    String? notes,
    @TimestampConverter() DateTime? timestamp,
    String? signatureB64,
    BadgePayload? badgePayload,
    String? receptionistUid,
    String? sessionId,
    String? assignedFloor,
  });

  $BadgePayloadCopyWith<$Res>? get badgePayload;
}

/// @nodoc
class _$ActiveSessionCopyWithImpl<$Res, $Val extends ActiveSession>
    implements $ActiveSessionCopyWith<$Res> {
  _$ActiveSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? screen = null,
    Object? status = freezed,
    Object? visitorName = freezed,
    Object? hostName = freezed,
    Object? hostId = freezed,
    Object? purpose = freezed,
    Object? notes = freezed,
    Object? timestamp = freezed,
    Object? signatureB64 = freezed,
    Object? badgePayload = freezed,
    Object? receptionistUid = freezed,
    Object? sessionId = freezed,
    Object? assignedFloor = freezed,
  }) {
    return _then(
      _value.copyWith(
            screen: null == screen
                ? _value.screen
                : screen // ignore: cast_nullable_to_non_nullable
                      as String,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            visitorName: freezed == visitorName
                ? _value.visitorName
                : visitorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            hostName: freezed == hostName
                ? _value.hostName
                : hostName // ignore: cast_nullable_to_non_nullable
                      as String?,
            hostId: freezed == hostId
                ? _value.hostId
                : hostId // ignore: cast_nullable_to_non_nullable
                      as String?,
            purpose: freezed == purpose
                ? _value.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            signatureB64: freezed == signatureB64
                ? _value.signatureB64
                : signatureB64 // ignore: cast_nullable_to_non_nullable
                      as String?,
            badgePayload: freezed == badgePayload
                ? _value.badgePayload
                : badgePayload // ignore: cast_nullable_to_non_nullable
                      as BadgePayload?,
            receptionistUid: freezed == receptionistUid
                ? _value.receptionistUid
                : receptionistUid // ignore: cast_nullable_to_non_nullable
                      as String?,
            sessionId: freezed == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            assignedFloor: freezed == assignedFloor
                ? _value.assignedFloor
                : assignedFloor // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ActiveSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BadgePayloadCopyWith<$Res>? get badgePayload {
    if (_value.badgePayload == null) {
      return null;
    }

    return $BadgePayloadCopyWith<$Res>(_value.badgePayload!, (value) {
      return _then(_value.copyWith(badgePayload: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ActiveSessionImplCopyWith<$Res>
    implements $ActiveSessionCopyWith<$Res> {
  factory _$$ActiveSessionImplCopyWith(
    _$ActiveSessionImpl value,
    $Res Function(_$ActiveSessionImpl) then,
  ) = __$$ActiveSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String screen,
    String? status,
    String? visitorName,
    String? hostName,
    String? hostId,
    String? purpose,
    String? notes,
    @TimestampConverter() DateTime? timestamp,
    String? signatureB64,
    BadgePayload? badgePayload,
    String? receptionistUid,
    String? sessionId,
    String? assignedFloor,
  });

  @override
  $BadgePayloadCopyWith<$Res>? get badgePayload;
}

/// @nodoc
class __$$ActiveSessionImplCopyWithImpl<$Res>
    extends _$ActiveSessionCopyWithImpl<$Res, _$ActiveSessionImpl>
    implements _$$ActiveSessionImplCopyWith<$Res> {
  __$$ActiveSessionImplCopyWithImpl(
    _$ActiveSessionImpl _value,
    $Res Function(_$ActiveSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActiveSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? screen = null,
    Object? status = freezed,
    Object? visitorName = freezed,
    Object? hostName = freezed,
    Object? hostId = freezed,
    Object? purpose = freezed,
    Object? notes = freezed,
    Object? timestamp = freezed,
    Object? signatureB64 = freezed,
    Object? badgePayload = freezed,
    Object? receptionistUid = freezed,
    Object? sessionId = freezed,
    Object? assignedFloor = freezed,
  }) {
    return _then(
      _$ActiveSessionImpl(
        screen: null == screen
            ? _value.screen
            : screen // ignore: cast_nullable_to_non_nullable
                  as String,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        visitorName: freezed == visitorName
            ? _value.visitorName
            : visitorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        hostName: freezed == hostName
            ? _value.hostName
            : hostName // ignore: cast_nullable_to_non_nullable
                  as String?,
        hostId: freezed == hostId
            ? _value.hostId
            : hostId // ignore: cast_nullable_to_non_nullable
                  as String?,
        purpose: freezed == purpose
            ? _value.purpose
            : purpose // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        signatureB64: freezed == signatureB64
            ? _value.signatureB64
            : signatureB64 // ignore: cast_nullable_to_non_nullable
                  as String?,
        badgePayload: freezed == badgePayload
            ? _value.badgePayload
            : badgePayload // ignore: cast_nullable_to_non_nullable
                  as BadgePayload?,
        receptionistUid: freezed == receptionistUid
            ? _value.receptionistUid
            : receptionistUid // ignore: cast_nullable_to_non_nullable
                  as String?,
        sessionId: freezed == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        assignedFloor: freezed == assignedFloor
            ? _value.assignedFloor
            : assignedFloor // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ActiveSessionImpl implements _ActiveSession {
  const _$ActiveSessionImpl({
    this.screen = 'idle',
    this.status,
    this.visitorName,
    this.hostName,
    this.hostId,
    this.purpose,
    this.notes,
    @TimestampConverter() this.timestamp,
    this.signatureB64,
    this.badgePayload,
    this.receptionistUid,
    this.sessionId,
    this.assignedFloor,
  });

  factory _$ActiveSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveSessionImplFromJson(json);

  @override
  @JsonKey()
  final String screen;
  // 'idle' | 'summary' | 'badge'
  @override
  final String? status;
  // 'pending_signature' | 'signed' | 'complete'
  @override
  final String? visitorName;
  @override
  final String? hostName;
  @override
  final String? hostId;
  @override
  final String? purpose;
  @override
  final String? notes;
  @override
  @TimestampConverter()
  final DateTime? timestamp;
  @override
  final String? signatureB64;
  @override
  final BadgePayload? badgePayload;
  @override
  final String? receptionistUid;
  @override
  final String? sessionId;
  @override
  final String? assignedFloor;

  @override
  String toString() {
    return 'ActiveSession(screen: $screen, status: $status, visitorName: $visitorName, hostName: $hostName, hostId: $hostId, purpose: $purpose, notes: $notes, timestamp: $timestamp, signatureB64: $signatureB64, badgePayload: $badgePayload, receptionistUid: $receptionistUid, sessionId: $sessionId, assignedFloor: $assignedFloor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveSessionImpl &&
            (identical(other.screen, screen) || other.screen == screen) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.visitorName, visitorName) ||
                other.visitorName == visitorName) &&
            (identical(other.hostName, hostName) ||
                other.hostName == hostName) &&
            (identical(other.hostId, hostId) || other.hostId == hostId) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.signatureB64, signatureB64) ||
                other.signatureB64 == signatureB64) &&
            (identical(other.badgePayload, badgePayload) ||
                other.badgePayload == badgePayload) &&
            (identical(other.receptionistUid, receptionistUid) ||
                other.receptionistUid == receptionistUid) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.assignedFloor, assignedFloor) ||
                other.assignedFloor == assignedFloor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    screen,
    status,
    visitorName,
    hostName,
    hostId,
    purpose,
    notes,
    timestamp,
    signatureB64,
    badgePayload,
    receptionistUid,
    sessionId,
    assignedFloor,
  );

  /// Create a copy of ActiveSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveSessionImplCopyWith<_$ActiveSessionImpl> get copyWith =>
      __$$ActiveSessionImplCopyWithImpl<_$ActiveSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveSessionImplToJson(this);
  }
}

abstract class _ActiveSession implements ActiveSession {
  const factory _ActiveSession({
    final String screen,
    final String? status,
    final String? visitorName,
    final String? hostName,
    final String? hostId,
    final String? purpose,
    final String? notes,
    @TimestampConverter() final DateTime? timestamp,
    final String? signatureB64,
    final BadgePayload? badgePayload,
    final String? receptionistUid,
    final String? sessionId,
    final String? assignedFloor,
  }) = _$ActiveSessionImpl;

  factory _ActiveSession.fromJson(Map<String, dynamic> json) =
      _$ActiveSessionImpl.fromJson;

  @override
  String get screen; // 'idle' | 'summary' | 'badge'
  @override
  String? get status; // 'pending_signature' | 'signed' | 'complete'
  @override
  String? get visitorName;
  @override
  String? get hostName;
  @override
  String? get hostId;
  @override
  String? get purpose;
  @override
  String? get notes;
  @override
  @TimestampConverter()
  DateTime? get timestamp;
  @override
  String? get signatureB64;
  @override
  BadgePayload? get badgePayload;
  @override
  String? get receptionistUid;
  @override
  String? get sessionId;
  @override
  String? get assignedFloor;

  /// Create a copy of ActiveSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveSessionImplCopyWith<_$ActiveSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BadgePayload _$BadgePayloadFromJson(Map<String, dynamic> json) {
  return _BadgePayload.fromJson(json);
}

/// @nodoc
mixin _$BadgePayload {
  String get visitId => throw _privateConstructorUsedError;
  String get visitorName => throw _privateConstructorUsedError;
  String get hostName => throw _privateConstructorUsedError;
  String get purpose => throw _privateConstructorUsedError;
  @RequiredTimestampConverter()
  DateTime get checkInTime => throw _privateConstructorUsedError;
  String get qrData => throw _privateConstructorUsedError;

  /// Serializes this BadgePayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BadgePayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BadgePayloadCopyWith<BadgePayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgePayloadCopyWith<$Res> {
  factory $BadgePayloadCopyWith(
    BadgePayload value,
    $Res Function(BadgePayload) then,
  ) = _$BadgePayloadCopyWithImpl<$Res, BadgePayload>;
  @useResult
  $Res call({
    String visitId,
    String visitorName,
    String hostName,
    String purpose,
    @RequiredTimestampConverter() DateTime checkInTime,
    String qrData,
  });
}

/// @nodoc
class _$BadgePayloadCopyWithImpl<$Res, $Val extends BadgePayload>
    implements $BadgePayloadCopyWith<$Res> {
  _$BadgePayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BadgePayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visitId = null,
    Object? visitorName = null,
    Object? hostName = null,
    Object? purpose = null,
    Object? checkInTime = null,
    Object? qrData = null,
  }) {
    return _then(
      _value.copyWith(
            visitId: null == visitId
                ? _value.visitId
                : visitId // ignore: cast_nullable_to_non_nullable
                      as String,
            visitorName: null == visitorName
                ? _value.visitorName
                : visitorName // ignore: cast_nullable_to_non_nullable
                      as String,
            hostName: null == hostName
                ? _value.hostName
                : hostName // ignore: cast_nullable_to_non_nullable
                      as String,
            purpose: null == purpose
                ? _value.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                      as String,
            checkInTime: null == checkInTime
                ? _value.checkInTime
                : checkInTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            qrData: null == qrData
                ? _value.qrData
                : qrData // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BadgePayloadImplCopyWith<$Res>
    implements $BadgePayloadCopyWith<$Res> {
  factory _$$BadgePayloadImplCopyWith(
    _$BadgePayloadImpl value,
    $Res Function(_$BadgePayloadImpl) then,
  ) = __$$BadgePayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String visitId,
    String visitorName,
    String hostName,
    String purpose,
    @RequiredTimestampConverter() DateTime checkInTime,
    String qrData,
  });
}

/// @nodoc
class __$$BadgePayloadImplCopyWithImpl<$Res>
    extends _$BadgePayloadCopyWithImpl<$Res, _$BadgePayloadImpl>
    implements _$$BadgePayloadImplCopyWith<$Res> {
  __$$BadgePayloadImplCopyWithImpl(
    _$BadgePayloadImpl _value,
    $Res Function(_$BadgePayloadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BadgePayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visitId = null,
    Object? visitorName = null,
    Object? hostName = null,
    Object? purpose = null,
    Object? checkInTime = null,
    Object? qrData = null,
  }) {
    return _then(
      _$BadgePayloadImpl(
        visitId: null == visitId
            ? _value.visitId
            : visitId // ignore: cast_nullable_to_non_nullable
                  as String,
        visitorName: null == visitorName
            ? _value.visitorName
            : visitorName // ignore: cast_nullable_to_non_nullable
                  as String,
        hostName: null == hostName
            ? _value.hostName
            : hostName // ignore: cast_nullable_to_non_nullable
                  as String,
        purpose: null == purpose
            ? _value.purpose
            : purpose // ignore: cast_nullable_to_non_nullable
                  as String,
        checkInTime: null == checkInTime
            ? _value.checkInTime
            : checkInTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        qrData: null == qrData
            ? _value.qrData
            : qrData // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$BadgePayloadImpl implements _BadgePayload {
  const _$BadgePayloadImpl({
    required this.visitId,
    required this.visitorName,
    required this.hostName,
    required this.purpose,
    @RequiredTimestampConverter() required this.checkInTime,
    required this.qrData,
  });

  factory _$BadgePayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$BadgePayloadImplFromJson(json);

  @override
  final String visitId;
  @override
  final String visitorName;
  @override
  final String hostName;
  @override
  final String purpose;
  @override
  @RequiredTimestampConverter()
  final DateTime checkInTime;
  @override
  final String qrData;

  @override
  String toString() {
    return 'BadgePayload(visitId: $visitId, visitorName: $visitorName, hostName: $hostName, purpose: $purpose, checkInTime: $checkInTime, qrData: $qrData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgePayloadImpl &&
            (identical(other.visitId, visitId) || other.visitId == visitId) &&
            (identical(other.visitorName, visitorName) ||
                other.visitorName == visitorName) &&
            (identical(other.hostName, hostName) ||
                other.hostName == hostName) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.checkInTime, checkInTime) ||
                other.checkInTime == checkInTime) &&
            (identical(other.qrData, qrData) || other.qrData == qrData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    visitId,
    visitorName,
    hostName,
    purpose,
    checkInTime,
    qrData,
  );

  /// Create a copy of BadgePayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgePayloadImplCopyWith<_$BadgePayloadImpl> get copyWith =>
      __$$BadgePayloadImplCopyWithImpl<_$BadgePayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BadgePayloadImplToJson(this);
  }
}

abstract class _BadgePayload implements BadgePayload {
  const factory _BadgePayload({
    required final String visitId,
    required final String visitorName,
    required final String hostName,
    required final String purpose,
    @RequiredTimestampConverter() required final DateTime checkInTime,
    required final String qrData,
  }) = _$BadgePayloadImpl;

  factory _BadgePayload.fromJson(Map<String, dynamic> json) =
      _$BadgePayloadImpl.fromJson;

  @override
  String get visitId;
  @override
  String get visitorName;
  @override
  String get hostName;
  @override
  String get purpose;
  @override
  @RequiredTimestampConverter()
  DateTime get checkInTime;
  @override
  String get qrData;

  /// Create a copy of BadgePayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BadgePayloadImplCopyWith<_$BadgePayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
