import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import 'staff_repository.dart';
import 'visit_repository.dart';
import 'session_repository.dart';
import 'mock_staff_repository.dart';
import 'mock_visit_repository.dart';
import 'mock_session_repository.dart';
import 'firestore_staff_repository.dart';
import 'firestore_visit_repository.dart';
import 'firestore_session_repository.dart';

// Abstract interface providers
final staffRepositoryProvider = Provider<StaffRepository>((ref) {
  if (kUseMockFirestore) {
    return MockStaffRepository();
  }
  return FirestoreStaffRepository();
});

final visitRepositoryProvider = Provider<VisitRepository>((ref) {
  if (kUseMockFirestore) {
    return MockVisitRepository();
  }
  return FirestoreVisitRepository();
});

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  if (kUseMockFirestore) {
    return MockSessionRepository();
  }
  return FirestoreSessionRepository();
});
