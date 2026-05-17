import '../models/staff.dart';
import 'staff_repository.dart';

class MockStaffRepository implements StaffRepository {
  final List<Staff> _mockStaff = [
    const Staff(id: '1', name: 'John Doe', department: 'Engineering', email: 'john@example.com'),
    const Staff(id: '2', name: 'Jane Smith', department: 'HR', email: 'jane@example.com'),
    const Staff(id: '3', name: 'Robert Brown', department: 'Sales', email: 'robert@example.com'),
    const Staff(id: '4', name: 'Alice White', department: 'Management', email: 'alice@example.com'),
  ];

  @override
  Future<List<Staff>> getAllStaff() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockStaff;
  }

  @override
  Future<Staff?> getStaffById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockStaff.firstWhere((s) => s.id == id, orElse: () => _mockStaff.first);
  }

  @override
  Stream<List<Staff>> watchAllStaff() async* {
    yield _mockStaff;
  }
}
