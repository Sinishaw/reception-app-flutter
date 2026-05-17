import 'package:rxdart/rxdart.dart';
import '../models/visit.dart';
import 'visit_repository.dart';

class MockVisitRepository implements VisitRepository {
  final _visitsSubject = BehaviorSubject<List<Visit>>.seeded([]);

  @override
  Future<void> createVisit(Visit visit) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final current = _visitsSubject.value;
    _visitsSubject.add([...current, visit]);
  }

  @override
  Future<void> updateVisit(Visit visit) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final current = _visitsSubject.value;
    final index = current.indexWhere((v) => v.id == visit.id);
    if (index != -1) {
      current[index] = visit;
      _visitsSubject.add([...current]);
    }
  }

  @override
  Future<Visit?> getVisitById(String id) async {
    return _visitsSubject.value.firstWhere((v) => v.id == id, orElse: () => throw Exception('Visit not found'));
  }

  @override
  Stream<List<Visit>> watchActiveVisits() {
    return _visitsSubject.stream.map((visits) => visits.where((v) => v.status == 'active').toList());
  }

  @override
  Stream<List<Visit>> watchVisitHistory() {
    return _visitsSubject.stream;
  }

  @override
  Future<void> checkOut(String visitId) async {
    final current = _visitsSubject.value;
    final index = current.indexWhere((v) => v.id == visitId);
    if (index != -1) {
      current[index] = current[index].copyWith(checkOutTime: DateTime.now(), status: 'checked_out');
      _visitsSubject.add([...current]);
    }
  }

  @override
  Future<void> deleteVisit(String visitId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final current = _visitsSubject.value;
    current.removeWhere((v) => v.id == visitId);
    _visitsSubject.add([...current]);
  }
}
