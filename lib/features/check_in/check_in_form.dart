import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../shared/models/station.dart';
import '../../shared/models/staff.dart';
import '../../shared/repositories/providers.dart';
import '../../shared/models/visit.dart';
import '../../shared/models/appointment.dart';
import '../notifications/notification_service.dart';
import '../pairing/station_provider.dart';
import '../../shared/services/floor_service.dart';
import '../tablet_display/session_provider.dart';
import 'id_scanner_section.dart';

class CheckInForm extends ConsumerStatefulWidget {
  final Appointment? initialAppointment;
  const CheckInForm({super.key, this.initialAppointment});

  @override
  ConsumerState<CheckInForm> createState() => _CheckInFormState();
}

class _CheckInFormState extends ConsumerState<CheckInForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _notesController = TextEditingController();
  final _floorController = TextEditingController();
  
  String? _selectedFloor;
  Staff? _selectedHost;
  String _purpose = 'Meeting';
  String _duration = '1 hr';
  String? _appointmentId;

  bool _isWaitingForSignature = false;
  String? _scannedIdUrl;

  @override
  void initState() {
    super.initState();
    if (widget.initialAppointment != null) {
      _nameController.text = widget.initialAppointment!.visitorName;
      _phoneController.text = widget.initialAppointment!.visitorPhone;
      _companyController.text = widget.initialAppointment!.visitorCompany ?? '';
      _purpose = widget.initialAppointment!.purpose;
      _notesController.text = widget.initialAppointment!.notes ?? '';
      _appointmentId = widget.initialAppointment!.id;
    }
  }

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
                        Text(
                          'New Walk-in Visitor',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        TextFormField(
                          controller: _nameController,
                          decoration: _softTouchDecoration('Visitor Full Name'),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                          enabled: !_isWaitingForSignature,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          decoration: _softTouchDecoration('Phone Number'),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                          enabled: !_isWaitingForSignature,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _companyController,
                          decoration: _softTouchDecoration('Company (Optional)'),
                          enabled: !_isWaitingForSignature,
                        ),
                        const SizedBox(height: 16),
                        _buildHostDropdown(),
                        const SizedBox(height: 16),
                        Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) async {
                            return await FloorService.fetchFloors(textEditingValue.text);
                          },
                          onSelected: (String selection) {
                            setState(() {
                              _selectedFloor = selection;
                            });
                          },
                          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                            if (controller.text != _floorController.text) {
                              controller.text = _floorController.text;
                            }
                            controller.addListener(() {
                              _floorController.text = controller.text;
                            });
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: _softTouchDecoration('Floor to Visit (Optional)').copyWith(
                                prefixIcon: const Icon(Icons.layers_rounded, color: AppColors.secondary),
                                suffixIcon: controller.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear_rounded, color: AppColors.secondary, size: 18),
                                        onPressed: () {
                                          controller.clear();
                                          setState(() {
                                            _selectedFloor = null;
                                          });
                                        },
                                      )
                                    : const Icon(Icons.arrow_drop_down_rounded, color: AppColors.secondary),
                              ),
                              enabled: !_isWaitingForSignature,
                              onFieldSubmitted: (v) => onFieldSubmitted(),
                            );
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 6.0,
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                child: Container(
                                  width: 400,
                                  constraints: const BoxConstraints(maxHeight: 200),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.secondary.withOpacity(0.1)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    separatorBuilder: (context, index) => Divider(
                                      height: 1,
                                      color: AppColors.secondary.withOpacity(0.05),
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      final String option = options.elementAt(index);
                                      return InkWell(
                                        onTap: () => onSelected(option),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          child: Text(
                                            option,
                                            style: const TextStyle(
                                              fontFamily: 'Manrope',
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.secondary,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _purpose,
                          decoration: _softTouchDecoration('Purpose'),
                          items: ['Meeting', 'Delivery', 'Interview', 'Other']
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: _isWaitingForSignature ? null : (v) => setState(() => _purpose = v!),
                        ),
                        const SizedBox(height: 32),
                        if (!_isWaitingForSignature)
                          Row(
                            children: [
                              _buildGradientButton(
                                onPressed: _sendToTablet,
                                child: const Text('Preview & Send to Visitor', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 16),
                              OutlinedButton(
                                onPressed: _clearForm,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  foregroundColor: AppColors.secondary,
                                  side: const BorderSide(color: AppColors.outlineVariant),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Clear Form'),
                              ),
                            ],
                          )
                        else if (!isSigned)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'Waiting for visitor to sign on tablet...',
                                    style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              OutlinedButton(
                                onPressed: _clearForm,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Cancel & Clear Form'),
                              ),
                            ],
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.green),
                                  SizedBox(width: 8),
                                  Text('Signature Received!', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  _buildGradientButton(
                                    onPressed: _confirmCheckIn,
                                    child: _isSubmitting
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                          )
                                        : const Text('Confirm & Check-in', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(width: 16),
                                  OutlinedButton(
                                    onPressed: _clearForm,
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                      foregroundColor: AppColors.secondary,
                                      side: const BorderSide(color: AppColors.outlineVariant),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.onSurface.withOpacity(0.04),
                          blurRadius: 32,
                          offset: const Offset(0, 12),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tablet Status',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        _buildStatusRow('Active Screen', session?.screen?.toUpperCase() ?? 'IDLE'),
                        const SizedBox(height: 12),
                        _buildStatusRow('Connection', session?.status?.toUpperCase() ?? 'N/A'),
                        if (isSigned && session?.signatureB64 != null) ...[
                          const SizedBox(height: 32),
                          Text(
                            'Visitor Signature',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors.secondary),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.memory(
                              base64Decode(session!.signatureB64!),
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                        const SizedBox(height: 32),
                        const Divider(),
                        const SizedBox(height: 24),
                        IdScannerSection(
                          visitorName: _nameController.text,
                          onUrlChanged: (url) {
                            setState(() {
                              _scannedIdUrl = url;
                            });
                          },
                        ),
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

  Widget _buildStatusRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w500)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _softTouchDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w500, fontSize: 14),
      filled: true,
      fillColor: AppColors.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    );
  }

  Widget _buildGradientButton({required VoidCallback? onPressed, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: onPressed != null
            ? const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: onPressed == null ? Colors.grey.shade300 : null,
        boxShadow: onPressed != null
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: child,
      ),
    );
  }

  Widget _buildHostDropdown() {
    final staffAsync = ref.watch(staffListProvider);
    return staffAsync.when(
      data: (staff) {
        if (_selectedHost == null && widget.initialAppointment != null && staff.isNotEmpty) {
          try {
            _selectedHost = staff.firstWhere((s) => s.id == widget.initialAppointment!.hostId);
          } catch (_) {
            _selectedHost = staff.first;
          }
        }
        return DropdownButtonFormField<Staff>(
          value: _selectedHost,
          decoration: _softTouchDecoration('Host / Person being visited'),
          items: staff.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
          onChanged: _isWaitingForSignature ? null : (v) => setState(() => _selectedHost = v),
          validator: (v) => v == null ? 'Required' : null,
        );
      },
      loading: () => const LinearProgressIndicator(),
      error: (e, s) => const Text('Error loading staff'),
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
        notes: _selectedFloor != null ? 'Floor: $_selectedFloor' : null,
        sessionId: ref.read(sessionIdProvider),
        assignedFloor: ref.read(assignedFloorProvider),
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
        appointmentId: _appointmentId,
        scannedIdUrl: _scannedIdUrl,
        notes: _selectedFloor != null ? 'Floor: $_selectedFloor' : null,
      );

      await ref.read(visitRepositoryProvider).createVisit(visit);

      if (_appointmentId != null) {
        try {
          final aptRepo = ref.read(appointmentRepositoryProvider);
          final apt = await aptRepo.getAppointmentById(_appointmentId!);
          if (apt != null) {
            await aptRepo.updateAppointment(apt.copyWith(status: 'checked_in', stationId: stationId));
          }
        } catch (e) {
          debugPrint('Error updating appointment status: $e');
        }
      }

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
          sessionId: ref.read(sessionIdProvider),
          assignedFloor: ref.read(assignedFloorProvider),
        ),
      );

      // 4. Reset form
      setState(() {
         _isWaitingForSignature = false;
         _nameController.clear();
         _phoneController.clear();
         _companyController.clear();
         _floorController.clear();
         _selectedFloor = null;
         _selectedHost = null;
         _scannedIdUrl = null;
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
      await ref.read(sessionRepositoryProvider).updateSession(
        stationId,
        ActiveSession(
          screen: 'idle',
          sessionId: ref.read(sessionIdProvider),
          assignedFloor: ref.read(assignedFloorProvider),
        ),
      );
    }
    setState(() {
      _isWaitingForSignature = false;
      _nameController.clear();
      _phoneController.clear();
      _companyController.clear();
      _notesController.clear();
      _floorController.clear();
      _selectedFloor = null;
      _selectedHost = null;
      _scannedIdUrl = null;
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

