import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment.dart';
import 'appointment_repository.dart';

class FirestoreAppointmentRepository implements AppointmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createAppointment(Appointment appointment) async {
    await _firestore.collection('appointments').doc(appointment.id).set(appointment.toJson());
  }

  @override
  Future<void> updateAppointment(Appointment appointment) async {
    await _firestore.collection('appointments').doc(appointment.id).update(appointment.toJson());
  }

  @override
  Future<void> deleteAppointment(String id) async {
    await _firestore.collection('appointments').doc(id).delete();
  }

  @override
  Future<Appointment?> getAppointmentById(String id) async {
    final doc = await _firestore.collection('appointments').doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return Appointment.fromJson(doc.data()!);
  }

  @override
  Stream<List<Appointment>> watchAppointments() {
    return _firestore
        .collection('appointments')
        .orderBy('scheduledAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Appointment.fromJson(doc.data())).toList();
    });
  }
}
