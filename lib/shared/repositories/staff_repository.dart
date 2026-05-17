import '../models/staff.dart';

abstract class StaffRepository {
  Future<List<Staff>> getAllStaff();
  Future<Staff?> getStaffById(String id);
  Stream<List<Staff>> watchAllStaff();
  
  // Future implementation: Frappe ERP sync
  // Future<void> syncWithFrappe();
}
