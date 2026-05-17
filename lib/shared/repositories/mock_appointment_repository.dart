import 'package:rxdart/rxdart.dart';
import '../models/appointment.dart';
import 'appointment_repository.dart';

class MockAppointmentRepository implements AppointmentRepository {
  final _appointmentsSubject = BehaviorSubject<List<Appointment>>.seeded([
    Appointment(
      id: 'apt_1',
      visitorName: 'Saron Belay',
      visitorPhone: '+251911223344',
      visitorCompany: 'Abyssinia Corp',
      hostId: 'staff_1',
      hostName: 'Dr. John Doe',
      purpose: 'Meeting',
      notes: 'Discussion on annual budget',
      scheduledAt: DateTime.now().add(const Duration(hours: 2)),
      status: 'scheduled',
      createdBy: 'receptionist_1',
      createdAt: DateTime.now(),
    ),
    Appointment(
      id: 'apt_2',
      visitorName: 'Samuel Girma',
      visitorPhone: '+251922334455',
      visitorCompany: 'MMCY Tech',
      hostId: 'staff_2',
      hostName: 'Jane Smith',
      purpose: 'Interview',
      notes: 'Final round technical interview',
      scheduledAt: DateTime.now().add(const Duration(hours: 4)),
      status: 'scheduled',
      createdBy: 'receptionist_1',
      createdAt: DateTime.now(),
    ),
    Appointment(
      id: 'apt_3',
      visitorName: 'Alemayehu Kebede',
      visitorPhone: '+251933445566',
      visitorCompany: 'Global Logistics',
      hostId: 'staff_1',
      hostName: 'Dr. John Doe',
      purpose: 'Delivery',
      notes: 'Document delivery',
      scheduledAt: DateTime.now().add(const Duration(days: 1)),
      status: 'scheduled',
      createdBy: 'receptionist_1',
      createdAt: DateTime.now(),
    ),
  ]);

  @override
  Future<void> createAppointment(Appointment appointment) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final current = _appointmentsSubject.value;
    _appointmentsSubject.add([...current, appointment]);
  }

  @override
  Future<void> updateAppointment(Appointment appointment) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final current = _appointmentsSubject.value;
    final index = current.indexWhere((a) => a.id == appointment.id);
    if (index != -1) {
      current[index] = appointment;
      _appointmentsSubject.add([...current]);
    }
  }

  @override
  Future<void> deleteAppointment(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final current = _appointmentsSubject.value;
    current.removeWhere((a) => a.id == id);
    _appointmentsSubject.add([...current]);
  }

  @override
  Future<Appointment?> getAppointmentById(String id) async {
    try {
      return _appointmentsSubject.value.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<List<Appointment>> watchAppointments() {
    return _appointmentsSubject.stream;
  }
}
