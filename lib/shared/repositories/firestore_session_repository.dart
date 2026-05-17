import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/station.dart';
import 'session_repository.dart';

class FirestoreSessionRepository implements SessionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<ActiveSession?> watchSession(String stationId) {
    return _firestore
        .collection('stations')
        .doc(stationId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }
      final data = snapshot.data()!;
      // Handle the nested activeSession map if it exists, or the document itself
      final sessionData = data['activeSession'] as Map<String, dynamic>? ?? data;
      return ActiveSession.fromJson(sessionData);
    });
  }

  @override
  Future<void> updateSession(String stationId, ActiveSession session) async {
    await _firestore.collection('stations').doc(stationId).set({
      'activeSession': session.toJson(),
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  Future<void> clearSession(String stationId) async {
    await _firestore.collection('stations').doc(stationId).update({
      'activeSession': {
        'screen': 'idle',
        'timestamp': FieldValue.serverTimestamp(),
      },
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<Station?> getStation(String stationId) async {
    final doc = await _firestore.collection('stations').doc(stationId).get();
    if (!doc.exists || doc.data() == null) return null;
    return Station.fromJson(doc.data()!);
  }

  @override
  Future<void> setStationOnline(String stationId, bool isOnline) async {
    await _firestore.collection('stations').doc(stationId).update({
      'isOnline': isOnline,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }
}
