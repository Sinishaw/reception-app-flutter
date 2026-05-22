import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'station_provider.g.dart';

@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError();
}

@riverpod
class StationId extends _$StationId {
  static const _key = 'station_id';

  @override
  String? build() {
    return ref.watch(sharedPreferencesProvider).getString(_key);
  }

  Future<void> set(String id) async {
    await ref.read(sharedPreferencesProvider).setString(_key, id);
    ref.invalidateSelf();
  }

  Future<void> clear() async {
    await ref.read(sharedPreferencesProvider).remove(_key);
    ref.invalidateSelf();
  }
}

@riverpod
class AssignedFloor extends _$AssignedFloor {
  static const _key = 'assigned_floor';

  @override
  String? build() {
    return ref.watch(sharedPreferencesProvider).getString(_key);
  }

  Future<void> set(String floor) async {
    await ref.read(sharedPreferencesProvider).setString(_key, floor);
    ref.invalidateSelf();
  }

  Future<void> clear() async {
    await ref.read(sharedPreferencesProvider).remove(_key);
    ref.invalidateSelf();
  }
}

@riverpod
class PairingTime extends _$PairingTime {
  static const _key = 'pairing_time';

  @override
  String? build() {
    return ref.watch(sharedPreferencesProvider).getString(_key);
  }

  Future<void> set(String timeIso) async {
    await ref.read(sharedPreferencesProvider).setString(_key, timeIso);
    ref.invalidateSelf();
  }

  Future<void> clear() async {
    await ref.read(sharedPreferencesProvider).remove(_key);
    ref.invalidateSelf();
  }
}

@riverpod
class SessionId extends _$SessionId {
  static const _key = 'session_id';

  @override
  String? build() {
    return ref.watch(sharedPreferencesProvider).getString(_key);
  }

  Future<void> set(String id) async {
    await ref.read(sharedPreferencesProvider).setString(_key, id);
    ref.invalidateSelf();
  }

  Future<void> clear() async {
    await ref.read(sharedPreferencesProvider).remove(_key);
    ref.invalidateSelf();
  }
}
