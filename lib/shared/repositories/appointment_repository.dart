import '../models/appointment.dart';

abstract class AppointmentRepository {
  Future<void> createAppointment(Appointment appointment);
  Future<void> updateAppointment(Appointment appointment);
  Future<void> deleteAppointment(String id);
  Future<Appointment?> getAppointmentById(String id);
  Stream<List<Appointment>> watchAppointments();
}
