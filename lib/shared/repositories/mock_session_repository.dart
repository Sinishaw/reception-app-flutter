import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/station.dart';
import 'session_repository.dart';

class MockSessionRepository implements SessionRepository {
  final Map<String, BehaviorSubject<ActiveSession?>> _sessions = {};
  final Map<String, Station> _stations = {
    'floor2-reception': const Station(id: 'floor2-reception', branchName: 'Main Branch', floor: '2', isOnline: true),
  };

  BehaviorSubject<ActiveSession?> _getOrBuilder(String stationId) {
    return _sessions.putIfAbsent(stationId, () => BehaviorSubject<ActiveSession?>.seeded(const ActiveSession(screen: 'idle')));
  }

  @override
  Stream<ActiveSession?> watchSession(String stationId) {
    return _getOrBuilder(stationId).stream;
  }

  @override
  Future<void> updateSession(String stationId, ActiveSession session) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _getOrBuilder(stationId).add(session);
  }

  @override
  Future<void> clearSession(String stationId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _getOrBuilder(stationId).add(const ActiveSession(screen: 'idle'));
  }

  @override
  Future<Station?> getStation(String stationId) async {
    return _stations[stationId];
  }

  @override
  Future<void> setStationOnline(String stationId, bool isOnline) async {
    final station = _stations[stationId];
    if (station != null) {
      _stations[stationId] = station.copyWith(isOnline: isOnline);
    }
  }
}
