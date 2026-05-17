import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme.dart';
import '../../shared/repositories/providers.dart';
import '../../shared/models/appointment.dart';
import '../../shared/models/staff.dart';
import '../../shared/models/visit.dart';
import '../pairing/station_provider.dart';
import '../check_in/check_in_form.dart';

class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  ConsumerState<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _statusFilter = 'All'; // 'All' | 'Scheduled' | 'Checked In' | 'Cancelled'
  
  int _currentPage = 0;
  int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
        _currentPage = 0; // Reset pagination on search
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }  InputDecoration _softTouchDecoration({
    required String hintText,
    String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelStyle: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w500, fontSize: 14),
      hintStyle: TextStyle(color: AppColors.secondary.withOpacity(0.6), fontSize: 14),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }

  Widget _buildGradientButton({
    required VoidCallback? onPressed,
    required Widget child,
    IconData? icon,
  }) {
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
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, color: Colors.white, size: 18) : const SizedBox.shrink(),
        label: child,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appointmentsAsync = ref.watch(appointmentListProvider);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Appointments',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Row(
                children: [
                  _buildGradientButton(
                    onPressed: () => _showAddAppointmentDialog(context),
                    icon: Icons.add,
                    child: const Text('Add Appointment', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () => _showImportDialog(context),
                    icon: const Icon(Icons.upload_file, size: 18),
                    label: const Text('Import expected', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.secondary,
                      side: const BorderSide(color: AppColors.outlineVariant),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download, size: 18),
                    label: const Text('Export to CSV', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.secondary,
                      side: const BorderSide(color: AppColors.outlineVariant),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Search & Filter Header
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _searchController,
                  decoration: _softTouchDecoration(
                    hintText: 'Search visitor name, host name, or company...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.secondary),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: AppColors.secondary),
                            onPressed: () => _searchController.clear(),
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  value: _statusFilter,
                  decoration: _softTouchDecoration(
                    hintText: 'Status Filter',
                    labelText: 'Status Filter',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All Statuses')),
                    DropdownMenuItem(value: 'scheduled', child: Text('Scheduled Only')),
                    DropdownMenuItem(value: 'checked_in', child: Text('Checked In Only')),
                    DropdownMenuItem(value: 'cancelled', child: Text('Cancelled Only')),
                  ],
                  onChanged: (v) {
                    if (v != null) {
                      setState(() {
                        _statusFilter = v;
                        _currentPage = 0; // Reset pagination
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Table Card
          Expanded(
            child: Container(
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: appointmentsAsync.when(
                  data: (appointments) {
                    // Filter in memory
                    final filtered = appointments.where((apt) {
                      // Filter by status
                      if (_statusFilter != 'All' && apt.status != _statusFilter) return false;

                      // Filter by search query
                      if (_searchQuery.isNotEmpty) {
                        final name = apt.visitorName.toLowerCase();
                        final phone = apt.visitorPhone.toLowerCase();
                        final company = (apt.visitorCompany ?? '').toLowerCase();
                        final host = apt.hostName.toLowerCase();
                        final purpose = apt.purpose.toLowerCase();
                        if (!name.contains(_searchQuery) &&
                            !phone.contains(_searchQuery) &&
                            !company.contains(_searchQuery) &&
                            !host.contains(_searchQuery) &&
                            !purpose.contains(_searchQuery)) {
                          return false;
                        }
                      }
                      return true;
                    }).toList();

                    final total = filtered.length;
                    final startIndex = _currentPage * _pageSize;
                    final endIndex = (startIndex + _pageSize < total)
                        ? startIndex + _pageSize
                        : total;
                    
                    final paginated = total > 0
                        ? filtered.sublist(startIndex, endIndex)
                        : <Appointment>[];

                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: SizedBox(
                              width: double.infinity,
                              child: DataTable(
                                headingRowColor: WidgetStateProperty.all(AppColors.surfaceContainerHighest),
                                horizontalMargin: 24,
                                dividerThickness: 0,
                                columns: const [
                                  DataColumn(label: Text('Visitor', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))),
                                  DataColumn(label: Text('Company', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))),
                                  DataColumn(label: Text('Host', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))),
                                  DataColumn(label: Text('Scheduled At', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))),
                                  DataColumn(label: Text('Purpose', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))),
                                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))),
                                  DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))),
                                ],
                                rows: List<DataRow>.generate(paginated.length, (index) {
                                  final apt = paginated[index];
                                  return DataRow(
                                    color: WidgetStateProperty.all(
                                      index.isEven ? Colors.transparent : AppColors.secondary.withOpacity(0.03),
                                    ),
                                    cells: [
                                      DataCell(Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(apt.visitorName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                          Text(apt.visitorPhone, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                        ],
                                      )),
                                      DataCell(Text(apt.visitorCompany ?? '--')),
                                      DataCell(Text(apt.hostName)),
                                      DataCell(Text(DateFormat('MMM dd, hh:mm a').format(apt.scheduledAt))),
                                      DataCell(Text(apt.purpose)),
                                      DataCell(_statusChip(apt.status)),
                                      DataCell(Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // View Details
                                          IconButton(
                                            icon: const Icon(Icons.visibility, color: Colors.deepPurple),
                                            tooltip: 'View Details',
                                            onPressed: () => _showDetailDialog(context, apt),
                                          ),
                                          // Edit
                                          IconButton(
                                            icon: const Icon(Icons.edit, color: Colors.blue),
                                            tooltip: 'Edit Appointment',
                                            onPressed: () => _showEditDialog(context, apt),
                                          ),
                                          // Convert Appointment to Visit Check-in
                                          if (apt.status == 'scheduled')
                                            IconButton(
                                              icon: const Icon(Icons.check_circle, color: Colors.green),
                                              tooltip: 'Check In Visitor',
                                              onPressed: () => _confirmCheckIn(context, apt),
                                            ),
                                          // Delete
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            tooltip: 'Delete Record',
                                            onPressed: () => _confirmDelete(context, apt),
                                          ),
                                        ],
                                      )),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        // Pagination
                        _buildPaginationControls(total, startIndex, endIndex),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, s) => Center(child: Text('Error: $e')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationControls(int total, int start, int end) {
    final pageCount = (total / _pageSize).ceil();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        color: Colors.grey.shade50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('Rows per page: '),
              const SizedBox(width: 8),
              DropdownButton<int>(
                value: _pageSize,
                underline: const SizedBox(),
                items: [5, 10, 20, 50]
                    .map((size) => DropdownMenuItem(value: size, child: Text('$size')))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _pageSize = value;
                      _currentPage = 0;
                    });
                  }
                },
              ),
            ],
          ),
          Text(total == 0 ? '0-0 of 0' : '${start + 1}-${end} of $total'),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.first_page),
                onPressed: _currentPage > 0 ? () => setState(() => _currentPage = 0) : null,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _currentPage > 0 ? () => setState(() => _currentPage--) : null,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: (end < total) ? () => setState(() => _currentPage++) : null,
              ),
              IconButton(
                icon: const Icon(Icons.last_page),
                onPressed: (end < total) ? () => setState(() => _currentPage = pageCount - 1) : null,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color;
    switch (status) {
      case 'scheduled':
        color = AppColors.tertiary;
        break;
      case 'checked_in':
        color = Colors.green;
        break;
      case 'cancelled':
        color = AppColors.primary;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(
          fontSize: 10, 
          color: color, 
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context, DateTime initial) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _showAddAppointmentDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final companyController = TextEditingController();
    final notesController = TextEditingController();
    
    DateTime selectedTime = DateTime.now().add(const Duration(hours: 1));
    Staff? selectedHost;
    String purpose = 'Meeting';
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add New Appointment'),
              content: Consumer(
                builder: (context, ref, child) {
                  final staffAsync = ref.watch(_staffListProvider);
                  return staffAsync.when(
                    data: (staffList) {
                      selectedHost ??= staffList.isNotEmpty ? staffList.first : null;

                      return Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: 500,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(labelText: 'Visitor Full Name', border: OutlineInputBorder()),
                                  validator: (v) => v!.isEmpty ? 'Required' : null,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: phoneController,
                                  decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                                  validator: (v) => v!.isEmpty ? 'Required' : null,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: companyController,
                                  decoration: const InputDecoration(labelText: 'Company (Optional)', border: OutlineInputBorder()),
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<Staff>(
                                  value: selectedHost,
                                  decoration: const InputDecoration(labelText: 'Host', border: OutlineInputBorder()),
                                  items: staffList.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
                                  onChanged: (v) => selectedHost = v,
                                  validator: (v) => v == null ? 'Required' : null,
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<String>(
                                  value: purpose,
                                  decoration: const InputDecoration(labelText: 'Purpose', border: OutlineInputBorder()),
                                  items: ['Meeting', 'Delivery', 'Interview', 'Other']
                                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (v) {
                                    if (v != null) purpose = v;
                                  },
                                ),
                                const SizedBox(height: 16),
                                InkWell(
                                  onTap: () async {
                                    final picked = await _selectDateTime(context, selectedTime);
                                    if (picked != null) {
                                      setDialogState(() => selectedTime = picked);
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      labelText: 'Scheduled Time',
                                      border: OutlineInputBorder(),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(DateFormat('MMM dd, yyyy - hh:mm a').format(selectedTime)),
                                        const Icon(Icons.calendar_today),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: notesController,
                                  decoration: const InputDecoration(labelText: 'Notes (Optional)', border: OutlineInputBorder()),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
                    error: (e, s) => Text('Error loading staff: $e'),
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      final apt = Appointment(
                        id: 'apt_${DateTime.now().millisecondsSinceEpoch}',
                        visitorName: nameController.text.trim(),
                        visitorPhone: phoneController.text.trim(),
                        visitorCompany: companyController.text.trim(),
                        hostId: selectedHost?.id ?? '',
                        hostName: selectedHost?.name ?? '',
                        purpose: purpose,
                        notes: notesController.text.trim(),
                        scheduledAt: selectedTime,
                        status: 'scheduled',
                        createdBy: 'receptionist_1',
                        createdAt: DateTime.now(),
                      );
                      
                      try {
                        await ref.read(appointmentRepositoryProvider).createAppointment(apt);
                        if (context.mounted) {
                          Navigator.pop(context);
                          _showFeedback(context, true, 'Appointment scheduled successfully');
                        }
                      } catch (e) {
                        if (context.mounted) {
                          _showFeedback(context, false, 'Error: $e');
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                  child: const Text('Add Appointment'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showEditDialog(BuildContext context, Appointment appointment) async {
    final nameController = TextEditingController(text: appointment.visitorName);
    final phoneController = TextEditingController(text: appointment.visitorPhone);
    final companyController = TextEditingController(text: appointment.visitorCompany);
    final notesController = TextEditingController(text: appointment.notes);
    
    DateTime selectedTime = appointment.scheduledAt;
    Staff? selectedHost;
    String purpose = appointment.purpose;
    String status = appointment.status;
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Edit Appointment - ${appointment.visitorName}'),
              content: Consumer(
                builder: (context, ref, child) {
                  final staffAsync = ref.watch(_staffListProvider);
                  return staffAsync.when(
                    data: (staffList) {
                      try {
                        selectedHost ??= staffList.firstWhere((s) => s.id == appointment.hostId);
                      } catch (_) {
                        selectedHost ??= staffList.isNotEmpty ? staffList.first : null;
                      }

                      return Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: 500,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(labelText: 'Visitor Full Name', border: OutlineInputBorder()),
                                  validator: (v) => v!.isEmpty ? 'Required' : null,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: phoneController,
                                  decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                                  validator: (v) => v!.isEmpty ? 'Required' : null,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: companyController,
                                  decoration: const InputDecoration(labelText: 'Company (Optional)', border: OutlineInputBorder()),
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<Staff>(
                                  value: selectedHost,
                                  decoration: const InputDecoration(labelText: 'Host', border: OutlineInputBorder()),
                                  items: staffList.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
                                  onChanged: (v) => selectedHost = v,
                                  validator: (v) => v == null ? 'Required' : null,
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<String>(
                                  value: purpose,
                                  decoration: const InputDecoration(labelText: 'Purpose', border: OutlineInputBorder()),
                                  items: ['Meeting', 'Delivery', 'Interview', 'Other']
                                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (v) {
                                    if (v != null) purpose = v;
                                  },
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<String>(
                                  value: status,
                                  decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
                                  items: ['scheduled', 'checked_in', 'cancelled']
                                      .map((e) => DropdownMenuItem(value: e, child: Text(e.toUpperCase())))
                                      .toList(),
                                  onChanged: (v) {
                                    if (v != null) {
                                      setDialogState(() => status = v);
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                                InkWell(
                                  onTap: () async {
                                    final picked = await _selectDateTime(context, selectedTime);
                                    if (picked != null) {
                                      setDialogState(() => selectedTime = picked);
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      labelText: 'Scheduled Time',
                                      border: OutlineInputBorder(),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(DateFormat('MMM dd, yyyy - hh:mm a').format(selectedTime)),
                                        const Icon(Icons.calendar_today),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: notesController,
                                  decoration: const InputDecoration(labelText: 'Notes (Optional)', border: OutlineInputBorder()),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
                    error: (e, s) => Text('Error loading staff: $e'),
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      final updated = appointment.copyWith(
                        visitorName: nameController.text.trim(),
                        visitorPhone: phoneController.text.trim(),
                        visitorCompany: companyController.text.trim(),
                        hostId: selectedHost?.id ?? appointment.hostId,
                        hostName: selectedHost?.name ?? appointment.hostName,
                        purpose: purpose,
                        status: status,
                        scheduledAt: selectedTime,
                        notes: notesController.text.trim(),
                      );
                      
                      try {
                        await ref.read(appointmentRepositoryProvider).updateAppointment(updated);
                        if (context.mounted) {
                          Navigator.pop(context);
                          _showFeedback(context, true, 'Appointment updated successfully');
                        }
                      } catch (e) {
                        if (context.mounted) {
                          _showFeedback(context, false, 'Error: $e');
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                  child: const Text('Save Changes'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmCheckIn(BuildContext context, Appointment appointment) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1050, maxHeight: 780),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: CheckInForm(initialAppointment: appointment),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, Appointment appointment) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Appointment', style: TextStyle(color: Colors.red)),
          content: Text('Are you sure you want to permanently delete the appointment of ${appointment.visitorName}? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(appointmentRepositoryProvider).deleteAppointment(appointment.id);
                  if (context.mounted) {
                    Navigator.pop(context);
                    _showFeedback(context, true, 'Appointment record deleted successfully');
                  }
                } catch (e) {
                  if (context.mounted) {
                    _showFeedback(context, false, 'Failed to delete: $e');
                  }
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showImportDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Import Expected Appointments', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      const Text('Upload spreadsheet files or connect to external databases to batch sync scheduled appointments.', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 32),
                      // Drag & drop mockup
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade50,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload_outlined, size: 64, color: AppColors.primary.withOpacity(0.6)),
                              const SizedBox(height: 16),
                              const Text('Drag & Drop Excel or CSV file here', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              const Text('Supported formats: .xls, .xlsx, .csv (Max 10MB)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  // Mock file picking success
                                  Navigator.pop(context);
                                  _showFeedback(context, true, 'Successfully parsed mock file: "expected_visitors_2026.xlsx". Import processed 25 new appointments!');
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                                child: const Text('Browse Files'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Database integrations row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Or import via external database:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _showFeedback(context, true, 'Connected to Oracle SQL Server. Successfully synced 12 new appointments.');
                                },
                                icon: const Icon(Icons.dns),
                                label: const Text('Oracle SQL'),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _showFeedback(context, true, 'Connected to Microsoft AD. Synchronized 8 scheduled guest accounts.');
                                },
                                icon: const Icon(Icons.hub),
                                label: const Text('Active Directory'),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFeedback(BuildContext context, bool success, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              success ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: success ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showDetailDialog(BuildContext context, Appointment appointment) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Appointment Details',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text('Appointment ID: ${appointment.id}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                          _statusChip(appointment.status),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left column
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailField('Visitor Full Name', appointment.visitorName),
                                    _buildDetailField('Phone Number', appointment.visitorPhone),
                                    _buildDetailField('Company', appointment.visitorCompany ?? '--'),
                                    _buildDetailField('Purpose of Visit', appointment.purpose),
                                    _buildDetailField('Notes', appointment.notes ?? '--'),
                                  ],
                                ),
                              ),
                              // Right column
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailField('Host Name', appointment.hostName),
                                    _buildDetailField('Scheduled At', DateFormat('MMMM dd, yyyy - hh:mm a').format(appointment.scheduledAt)),
                                    _buildDetailField('Created By', appointment.createdBy ?? '--'),
                                    _buildDetailField('Created At', appointment.createdAt != null
                                        ? DateFormat('MMMM dd, yyyy - hh:mm a').format(appointment.createdAt!)
                                        : '--'),
                                    _buildDetailField('Station ID', appointment.stationId ?? '--'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      // Actions footer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                          const SizedBox(width: 12),
                          // Edit Action
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context); // Close details
                              _showEditDialog(context, appointment);
                            },
                            icon: const Icon(Icons.edit, size: 16),
                            label: const Text('Edit'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(color: Colors.blue),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Check-In Action (Convert)
                          if (appointment.status == 'scheduled')
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context); // Close details
                                _confirmCheckIn(context, appointment);
                              },
                              icon: const Icon(Icons.check_circle, size: 16),
                              label: const Text('Check In'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          const SizedBox(width: 12),
                          // Delete Action
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context); // Close details
                              _confirmDelete(context, appointment);
                            },
                            icon: const Icon(Icons.delete, size: 16),
                            label: const Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

final appointmentListProvider = StreamProvider<List<Appointment>>((ref) {
  return ref.watch(appointmentRepositoryProvider).watchAppointments();
});

final _staffListProvider = StreamProvider<List<Staff>>((ref) {
  return ref.watch(staffRepositoryProvider).watchAllStaff();
});
