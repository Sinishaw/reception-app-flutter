import '../models/station.dart';

abstract class SessionRepository {
  Stream<ActiveSession?> watchSession(String stationId);
  Future<void> updateSession(String stationId, ActiveSession session);
  Future<void> clearSession(String stationId);
  
  // Station pairing
  Future<Station?> getStation(String stationId);
  Future<void> setStationOnline(String stationId, bool isOnline);
}
