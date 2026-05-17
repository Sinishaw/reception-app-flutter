import '../models/visit.dart';

abstract class VisitRepository {
  Future<void> createVisit(Visit visit);
  Future<void> updateVisit(Visit visit);
  Future<Visit?> getVisitById(String id);
  Stream<List<Visit>> watchActiveVisits();
  Stream<List<Visit>> watchVisitHistory();
  Future<void> checkOut(String visitId);
}
