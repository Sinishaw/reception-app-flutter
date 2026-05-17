import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'station_provider.g.dart';

@riverpod
class StationId extends _$StationId {
  static const _key = 'station_id';

  @override
  String? build() {
    _load();
    return null;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString(_key);
  }

  Future<void> set(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, id);
    state = id;
  }
}
