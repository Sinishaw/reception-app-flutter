import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/visit.dart';
import 'visit_repository.dart';

class FirestoreVisitRepository implements VisitRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createVisit(Visit visit) async {
    await _firestore.collection('visits').doc(visit.id).set(visit.toJson());
  }

  @override
  Future<void> updateVisit(Visit visit) async {
    await _firestore.collection('visits').doc(visit.id).update(visit.toJson());
  }

  @override
  Future<Visit?> getVisitById(String id) async {
    final doc = await _firestore.collection('visits').doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return Visit.fromJson(doc.data()!);
  }

  @override
  Stream<List<Visit>> watchActiveVisits() {
    return _firestore
        .collection('visits')
        .where('status', whereIn: ['expected', 'checked_in'])
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Visit.fromJson(doc.data())).toList();
    });
  }

  @override
  Stream<List<Visit>> watchVisitHistory() {
    return _firestore
        .collection('visits')
        .orderBy('checkInTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Visit.fromJson(doc.data())).toList();
    });
  }

  @override
  Future<void> checkOut(String visitId) async {
    await _firestore.collection('visits').doc(visitId).update({
      'status': 'checked_out',
      'checkOutTime': FieldValue.serverTimestamp(),
    });
  }
}
