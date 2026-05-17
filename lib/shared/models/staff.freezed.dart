// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Staff _$StaffFromJson(Map<String, dynamic> json) {
  return _Staff.fromJson(json);
}

/// @nodoc
mixin _$Staff {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;
  bool get notifyOnArrival => throw _privateConstructorUsedError;
  bool get notifyOnCheckout => throw _privateConstructorUsedError;
  bool get notifyBeforeAppointment => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this Staff to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffCopyWith<Staff> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffCopyWith<$Res> {
  factory $StaffCopyWith(Staff value, $Res Function(Staff) then) =
      _$StaffCopyWithImpl<$Res, Staff>;
  @useResult
  $Res call({
    String id,
    String name,
    String? department,
    String? email,
    String? phone,
    String? fcmToken,
    bool notifyOnArrival,
    bool notifyOnCheckout,
    bool notifyBeforeAppointment,
    bool isActive,
  });
}

/// @nodoc
class _$StaffCopyWithImpl<$Res, $Val extends Staff>
    implements $StaffCopyWith<$Res> {
  _$StaffCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? department = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? fcmToken = freezed,
    Object? notifyOnArrival = null,
    Object? notifyOnCheckout = null,
    Object? notifyBeforeAppointment = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            department: freezed == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            fcmToken: freezed == fcmToken
                ? _value.fcmToken
                : fcmToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            notifyOnArrival: null == notifyOnArrival
                ? _value.notifyOnArrival
                : notifyOnArrival // ignore: cast_nullable_to_non_nullable
                      as bool,
            notifyOnCheckout: null == notifyOnCheckout
                ? _value.notifyOnCheckout
                : notifyOnCheckout // ignore: cast_nullable_to_non_nullable
                      as bool,
            notifyBeforeAppointment: null == notifyBeforeAppointment
                ? _value.notifyBeforeAppointment
                : notifyBeforeAppointment // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffImplCopyWith<$Res> implements $StaffCopyWith<$Res> {
  factory _$$StaffImplCopyWith(
    _$StaffImpl value,
    $Res Function(_$StaffImpl) then,
  ) = __$$StaffImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? department,
    String? email,
    String? phone,
    String? fcmToken,
    bool notifyOnArrival,
    bool notifyOnCheckout,
    bool notifyBeforeAppointment,
    bool isActive,
  });
}

/// @nodoc
class __$$StaffImplCopyWithImpl<$Res>
    extends _$StaffCopyWithImpl<$Res, _$StaffImpl>
    implements _$$StaffImplCopyWith<$Res> {
  __$$StaffImplCopyWithImpl(
    _$StaffImpl _value,
    $Res Function(_$StaffImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? department = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? fcmToken = freezed,
    Object? notifyOnArrival = null,
    Object? notifyOnCheckout = null,
    Object? notifyBeforeAppointment = null,
    Object? isActive = null,
  }) {
    return _then(
      _$StaffImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        department: freezed == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        fcmToken: freezed == fcmToken
            ? _value.fcmToken
            : fcmToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        notifyOnArrival: null == notifyOnArrival
            ? _value.notifyOnArrival
            : notifyOnArrival // ignore: cast_nullable_to_non_nullable
                  as bool,
        notifyOnCheckout: null == notifyOnCheckout
            ? _value.notifyOnCheckout
            : notifyOnCheckout // ignore: cast_nullable_to_non_nullable
                  as bool,
        notifyBeforeAppointment: null == notifyBeforeAppointment
            ? _value.notifyBeforeAppointment
            : notifyBeforeAppointment // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffImpl implements _Staff {
  const _$StaffImpl({
    required this.id,
    required this.name,
    this.department,
    this.email,
    this.phone,
    this.fcmToken,
    this.notifyOnArrival = true,
    this.notifyOnCheckout = false,
    this.notifyBeforeAppointment = true,
    this.isActive = true,
  });

  factory _$StaffImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? department;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? fcmToken;
  @override
  @JsonKey()
  final bool notifyOnArrival;
  @override
  @JsonKey()
  final bool notifyOnCheckout;
  @override
  @JsonKey()
  final bool notifyBeforeAppointment;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'Staff(id: $id, name: $name, department: $department, email: $email, phone: $phone, fcmToken: $fcmToken, notifyOnArrival: $notifyOnArrival, notifyOnCheckout: $notifyOnCheckout, notifyBeforeAppointment: $notifyBeforeAppointment, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.notifyOnArrival, notifyOnArrival) ||
                other.notifyOnArrival == notifyOnArrival) &&
            (identical(other.notifyOnCheckout, notifyOnCheckout) ||
                other.notifyOnCheckout == notifyOnCheckout) &&
            (identical(
                  other.notifyBeforeAppointment,
                  notifyBeforeAppointment,
                ) ||
                other.notifyBeforeAppointment == notifyBeforeAppointment) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    department,
    email,
    phone,
    fcmToken,
    notifyOnArrival,
    notifyOnCheckout,
    notifyBeforeAppointment,
    isActive,
  );

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      __$$StaffImplCopyWithImpl<_$StaffImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffImplToJson(this);
  }
}

abstract class _Staff implements Staff {
  const factory _Staff({
    required final String id,
    required final String name,
    final String? department,
    final String? email,
    final String? phone,
    final String? fcmToken,
    final bool notifyOnArrival,
    final bool notifyOnCheckout,
    final bool notifyBeforeAppointment,
    final bool isActive,
  }) = _$StaffImpl;

  factory _Staff.fromJson(Map<String, dynamic> json) = _$StaffImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get department;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get fcmToken;
  @override
  bool get notifyOnArrival;
  @override
  bool get notifyOnCheckout;
  @override
  bool get notifyBeforeAppointment;
  @override
  bool get isActive;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
