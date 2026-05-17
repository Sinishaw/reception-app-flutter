import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../shared/models/station.dart';
import '../../shared/models/staff.dart';
import '../../shared/repositories/providers.dart';
import '../../shared/models/visit.dart';
import '../notifications/notification_service.dart';
import '../pairing/station_provider.dart';
import '../tablet_display/session_provider.dart';

class CheckInForm extends ConsumerStatefulWidget {
  const CheckInForm({super.key});

  @override
  ConsumerState<CheckInForm> createState() => _CheckInFormState();
}

class _CheckInFormState extends ConsumerState<CheckInForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _notesController = TextEditingController();
  
  Staff? _selectedHost;
  String _purpose = 'Meeting';
  String _duration = '1 hr';

  bool _isWaitingForSignature = false;

  @override
  Widget build(BuildContext context) {
    final stationId = ref.watch(stationIdProvider);
    final sessionAsync = ref.watch(activeSessionProvider);

    if (stationId == null) {
      return const Center(child: Text('Please configure Station ID in Settings.'));
    }

    return sessionAsync.when(
      data: (session) {
        final isSigned = session?.status == 'signed';
        
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Form
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('New Walk-in Visitor', style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 32),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Visitor Full Name', border: OutlineInputBorder()),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                          enabled: !_isWaitingForSignature,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                          enabled: !_isWaitingForSignature,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _companyController,
                          decoration: const InputDecoration(labelText: 'Company (Optional)', border: OutlineInputBorder()),
                          enabled: !_isWaitingForSignature,
                        ),
                        const SizedBox(height: 16),
                        _buildHostDropdown(),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _purpose,
                          decoration: const InputDecoration(labelText: 'Purpose', border: OutlineInputBorder()),
                          items: ['Meeting', 'Delivery', 'Interview', 'Other'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: _isWaitingForSignature ? null : (v) => setState(() => _purpose = v!),
                        ),
                        const SizedBox(height: 32),
                        if (!_isWaitingForSignature)
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: _sendToTablet,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                ),
                                child: const Text('Preview & Send to Visitor'),
                              ),
                              const SizedBox(width: 16),
                              OutlinedButton(
                                onPressed: _clearForm,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                ),
                                child: const Text('Clear Form'),
                              ),
                            ],
                          )
                        else if (!isSigned)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 16),
                                  Text('Waiting for visitor to sign on tablet...'),
                                ],
                              ),
                              const SizedBox(height: 24),
                              OutlinedButton(
                                onPressed: _clearForm,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                ),
                                child: const Text('Cancel & Clear Form'),
                              ),
                            ],
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Signature Received!', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: _confirmCheckIn,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.accent,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                    ),
                                    child: _isSubmitting 
                                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                      : const Text('Confirm & Check-in'),
                                  ),
                                  const SizedBox(width: 16),
                                  OutlinedButton(
                                    onPressed: _clearForm,
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                    ),
                                    child: const Text('Clear Form'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 48),
                // Right Column: Preview/Status
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tablet Status', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Text('Mode: ${session?.screen ?? 'idle'}'),
                        Text('Status: ${session?.status ?? 'N/A'}'),
                        const Divider(height: 32),
                        if (isSigned && session?.signatureB64 != null)
                          Image.memory(base64Decode(session!.signatureB64!), height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildHostDropdown() {
    final staffAsync = ref.watch(staffListProvider);
    return staffAsync.when(
      data: (staff) => DropdownButtonFormField<Staff>(
        value: _selectedHost,
        decoration: const InputDecoration(labelText: 'Host / Person being visited', border: OutlineInputBorder()),
        items: staff.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
        onChanged: _isWaitingForSignature ? null : (v) => setState(() => _selectedHost = v),
        validator: (v) => v == null ? 'Required' : null,
      ),
      loading: () => const LinearProgressIndicator(),
      error: (e, s) => Text('Error loading staff'),
    );
  }

  Future<void> _sendToTablet() async {
    if (!_formKey.currentState!.validate()) return;

    final stationId = ref.read(stationIdProvider);
    if (stationId == null) return;

    setState(() => _isWaitingForSignature = true);

    await ref.read(sessionRepositoryProvider).updateSession(
      stationId,
      ActiveSession(
        screen: 'summary',
        status: 'pending_signature',
        visitorName: _nameController.text,
        hostName: _selectedHost?.name,
        hostId: _selectedHost?.id,
        purpose: _purpose,
        timestamp: DateTime.now(),
      ),
    );
  }

  bool _isSubmitting = false;

  Future<void> _confirmCheckIn() async {
    if (_isSubmitting) return;

    final stationId = ref.read(stationIdProvider);
    if (stationId == null) return;

    final session = ref.read(activeSessionProvider).value;
    if (session == null) return;

    setState(() => _isSubmitting = true);

    try {
      // 1. Create the final Visit record
      final visitId = DateTime.now().millisecondsSinceEpoch.toString();
      final visit = Visit(
        id: visitId,
        visitorName: _nameController.text,
        visitorPhone: _phoneController.text,
        visitorCompany: _companyController.text,
        hostId: _selectedHost?.id ?? '',
        hostName: _selectedHost?.name ?? '',
        purpose: _purpose,
        stationId: stationId,
        checkInTime: DateTime.now(),
        createdBy: 'receptionist-1', // Mock UID
        createdAt: DateTime.now(),
        signatureB64: session.signatureB64,
      );

      await ref.read(visitRepositoryProvider).createVisit(visit);

      // 2. Simulate Cloud Function triggering a notification to the host
      Future.delayed(const Duration(seconds: 2), () {
        NotificationService.showArrivalNotification(visit.visitorName, stationId);
      });

      // 3. Update session to show badge on tablet
      await ref.read(sessionRepositoryProvider).updateSession(
        stationId,
        ActiveSession(
          screen: 'badge',
          status: 'complete',
          badgePayload: BadgePayload(
            visitId: visitId,
            visitorName: visit.visitorName,
            hostName: visit.hostName,
            purpose: visit.purpose,
            checkInTime: visit.checkInTime,
            qrData: visitId,
          ),
        ),
      );

      // 4. Reset form
      setState(() {
         _isWaitingForSignature = false;
         _nameController.clear();
         _phoneController.clear();
         _companyController.clear();
         _selectedHost = null;
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Check-in successful!')),
        );
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  Future<void> _clearForm() async {
    final stationId = ref.read(stationIdProvider);
    if (stationId != null) {
      await ref.read(sessionRepositoryProvider).clearSession(stationId);
    }
    setState(() {
      _isWaitingForSignature = false;
      _nameController.clear();
      _phoneController.clear();
      _companyController.clear();
      _notesController.clear();
      _selectedHost = null;
      _purpose = 'Meeting';
    });
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form cleared successfully')),
      );
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }
}

// Simple provider for staff list
final staffListProvider = StreamProvider<List<Staff>>((ref) {
  return ref.watch(staffRepositoryProvider).watchAllStaff();
});

