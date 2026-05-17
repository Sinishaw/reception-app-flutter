import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff.freezed.dart';
part 'staff.g.dart';

@freezed
class Staff with _$Staff {
  const factory Staff({
    required String id,
    required String name,
    String? department,
    String? email,
    String? phone,
    String? fcmToken,
    @Default(true) bool notifyOnArrival,
    @Default(false) bool notifyOnCheckout,
    @Default(true) bool notifyBeforeAppointment,
    @Default(true) bool isActive,
  }) = _Staff;

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);
}
