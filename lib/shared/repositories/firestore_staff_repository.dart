import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/staff.dart';
import 'staff_repository.dart';

class FirestoreStaffRepository implements StaffRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Staff>> getAllStaff() async {
    final snapshot = await _firestore.collection('staff').get();
    if (snapshot.docs.isEmpty) {
      return [
        const Staff(id: 's1', name: 'John Doe', department: 'Engineering'),
        const Staff(id: 's2', name: 'Jane Smith', department: 'HR'),
      ];
    }
    return snapshot.docs.map((doc) => Staff.fromJson(doc.data())).toList();
  }

  @override
  Future<Staff?> getStaffById(String id) async {
    final doc = await _firestore.collection('staff').doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return Staff.fromJson(doc.data()!);
  }

  @override
  Stream<List<Staff>> watchAllStaff() {
    return _firestore.collection('staff').snapshots().map((snapshot) {
      if (snapshot.docs.isEmpty) {
        // Fallback for empty database during initial testing
        return [
           const Staff(id: 's1', name: 'John Doe', department: 'Engineering'),
           const Staff(id: 's2', name: 'Jane Smith', department: 'HR'),
        ];
      }
      return snapshot.docs.map((doc) => Staff.fromJson(doc.data())).toList();
    });
  }
}
