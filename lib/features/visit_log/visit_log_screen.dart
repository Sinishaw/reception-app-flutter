import 'dart:convert';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme.dart';
import '../../shared/repositories/providers.dart';
import '../../shared/models/visit.dart';
import '../../shared/models/staff.dart';
import '../check_in/check_in_form.dart';

class VisitLogScreen extends ConsumerStatefulWidget {
  const VisitLogScreen({super.key});

  @override
  ConsumerState<VisitLogScreen> createState() => _VisitLogScreenState();
}

class _VisitLogScreenState extends ConsumerState<VisitLogScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _statusFilter = 'All'; // 'All' | 'Active' | 'Checked Out'
  
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
  }

  InputDecoration _softTouchDecoration({
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
    final visitsAsync = ref.watch(visitListProvider);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Visitors',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Row(
                children: [
                  _buildGradientButton(
                    onPressed: () => _showAddVisitorDialog(context),
                    icon: Icons.add,
                    child: const Text('Add Visitor', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    hintText: 'Search visitors, hosts, or company...',
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
                    DropdownMenuItem(value: 'Active', child: Text('Active Only')),
                    DropdownMenuItem(value: 'Checked Out', child: Text('Checked Out Only')),
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
                child: visitsAsync.when(
                  data: (visits) {
                    // Filter in memory
                    final filteredVisits = visits.where((visit) {
                      // Filter by status
                      if (_statusFilter == 'Active' && visit.status != 'active') return false;
                      if (_statusFilter == 'Checked Out' && visit.status != 'checked_out') return false;

                      // Filter by search query
                      if (_searchQuery.isNotEmpty) {
                        final name = visit.visitorName.toLowerCase();
                        final phone = visit.visitorPhone.toLowerCase();
                        final company = (visit.visitorCompany ?? '').toLowerCase();
                        final host = visit.hostName.toLowerCase();
                        final purpose = visit.purpose.toLowerCase();
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

                    final totalFiltered = filteredVisits.length;
                    final startIndex = _currentPage * _pageSize;
                    final endIndex = (startIndex + _pageSize < totalFiltered)
                        ? startIndex + _pageSize
                        : totalFiltered;
                    
                    final paginatedVisits = totalFiltered > 0
                        ? filteredVisits.sublist(startIndex, endIndex)
                        : <Visit>[];

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
                                  DataColumn(label: Text('Check-in', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))),
                                  DataColumn(label: Text('Check-out', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))),
                                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))),
                                  DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))),
                                ],
                                rows: List<DataRow>.generate(paginatedVisits.length, (index) {
                                  final visit = paginatedVisits[index];
                                  return DataRow(
                                    color: WidgetStateProperty.all(
                                      index.isEven ? Colors.transparent : AppColors.secondary.withOpacity(0.03),
                                    ),
                                    cells: [
                                      DataCell(Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(visit.visitorName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                          Text(visit.visitorPhone, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                        ],
                                      )),
                                      DataCell(Text(visit.visitorCompany ?? '--')),
                                      DataCell(Text(visit.hostName)),
                                      DataCell(Text(DateFormat('MMM dd, hh:mm a').format(visit.checkInTime))),
                                      DataCell(Text(visit.checkOutTime != null 
                                          ? DateFormat('hh:mm a').format(visit.checkOutTime!) 
                                          : '--')),
                                      DataCell(_statusChip(visit.status)),
                                      DataCell(Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // View Details
                                          IconButton(
                                            icon: const Icon(Icons.visibility, color: Colors.deepPurple),
                                            tooltip: 'View Details',
                                            onPressed: () => _showDetailDialog(context, visit),
                                          ),
                                          // Edit
                                          IconButton(
                                            icon: const Icon(Icons.edit, color: Colors.blue),
                                            tooltip: 'Edit Visit',
                                            onPressed: () => _showEditDialog(context, visit),
                                          ),
                                          // Check-in / Out Toggle
                                          if (visit.status == 'active')
                                            IconButton(
                                              icon: const Icon(Icons.logout, color: Colors.orange),
                                              tooltip: 'Check Out',
                                              onPressed: () => _confirmCheckOut(context, visit),
                                            )
                                          else
                                            IconButton(
                                              icon: const Icon(Icons.login, color: Colors.green),
                                              tooltip: 'Check In Again',
                                              onPressed: () => _confirmCheckIn(context, visit),
                                            ),
                                          // Delete
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            tooltip: 'Delete Record',
                                            onPressed: () => _confirmDelete(context, visit),
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
                        // Pagination controls
                        _buildPaginationControls(totalFiltered, startIndex, endIndex),
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
    final isActive = status == 'active';
    final color = isActive ? Colors.green : AppColors.secondary;
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

  Future<void> _showEditDialog(BuildContext context, Visit visit) async {
    final nameController = TextEditingController(text: visit.visitorName);
    final phoneController = TextEditingController(text: visit.visitorPhone);
    final companyController = TextEditingController(text: visit.visitorCompany);
    final notesController = TextEditingController(text: visit.notes);
    final durationController = TextEditingController(text: visit.expectedDuration);
    
    Staff? selectedHost;
    String purpose = visit.purpose;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Visit - ${visit.visitorName}'),
          content: Consumer(
            builder: (context, ref, child) {
              final staffAsync = ref.watch(_staffListProvider);
              return staffAsync.when(
                data: (staffList) {
                  try {
                    selectedHost ??= staffList.firstWhere((s) => s.id == visit.hostId);
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
                              value: ['Meeting', 'Delivery', 'Interview', 'Other'].contains(purpose) ? purpose : 'Meeting',
                              decoration: const InputDecoration(labelText: 'Purpose', border: OutlineInputBorder()),
                              items: ['Meeting', 'Delivery', 'Interview', 'Other']
                                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) purpose = v;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: durationController,
                              decoration: const InputDecoration(labelText: 'Expected Duration', border: OutlineInputBorder()),
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
                  final updatedVisit = visit.copyWith(
                    visitorName: nameController.text.trim(),
                    visitorPhone: phoneController.text.trim(),
                    visitorCompany: companyController.text.trim(),
                    hostId: selectedHost?.id ?? visit.hostId,
                    hostName: selectedHost?.name ?? visit.hostName,
                    purpose: purpose,
                    expectedDuration: durationController.text.trim(),
                    notes: notesController.text.trim(),
                  );
                  
                  try {
                    await ref.read(visitRepositoryProvider).updateVisit(updatedVisit);
                    if (context.mounted) {
                      Navigator.pop(context);
                      _showFeedback(context, true, 'Visit record updated successfully');
                    }
                  } catch (e) {
                    if (context.mounted) {
                      _showFeedback(context, false, 'Failed to update visit: $e');
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
  }

  Future<void> _confirmCheckOut(BuildContext context, Visit visit) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Check Out Visitor'),
          content: Text('Are you sure you want to check out ${visit.visitorName}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(visitRepositoryProvider).checkOut(visit.id);
                  if (context.mounted) {
                    Navigator.pop(context);
                    _showFeedback(context, true, '${visit.visitorName} checked out successfully');
                  }
                } catch (e) {
                  if (context.mounted) {
                    _showFeedback(context, false, 'Failed to check out: $e');
                  }
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
              child: const Text('Check Out'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmCheckIn(BuildContext context, Visit visit) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Check In Visitor'),
          content: Text('Are you sure you want to check in ${visit.visitorName} again?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final updatedVisit = visit.copyWith(
                    status: 'active',
                    checkInTime: DateTime.now(),
                    checkOutTime: null,
                  );
                  await ref.read(visitRepositoryProvider).updateVisit(updatedVisit);
                  if (context.mounted) {
                    Navigator.pop(context);
                    _showFeedback(context, true, '${visit.visitorName} checked in successfully');
                  }
                } catch (e) {
                  if (context.mounted) {
                    _showFeedback(context, false, 'Failed to check in: $e');
                  }
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              child: const Text('Check In'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, Visit visit) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Visit Record', style: TextStyle(color: Colors.red)),
          content: Text('Are you sure you want to permanently delete the visit record of ${visit.visitorName}? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (visit.appointmentId != null) {
                    try {
                      final aptRepo = ref.read(appointmentRepositoryProvider);
                      final apt = await aptRepo.getAppointmentById(visit.appointmentId!);
                      if (apt != null) {
                        await aptRepo.updateAppointment(apt.copyWith(status: 'scheduled'));
                      }
                    } catch (e) {
                      debugPrint('Failed to revert appointment: $e');
                    }
                  }

                  await ref.read(visitRepositoryProvider).deleteVisit(visit.id);
                  if (context.mounted) {
                    Navigator.pop(context);
                    _showFeedback(context, true, 'Visit record deleted successfully');
                  }
                } catch (e) {
                  if (context.mounted) {
                    _showFeedback(context, false, 'Failed to delete record: $e');
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

  void _showAddVisitorDialog(BuildContext context) {
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
                const Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: CheckInForm(),
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

  void _showDetailDialog(BuildContext context, Visit visit) {
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
                                'Visitor Details',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text('Visit ID: ${visit.id}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                          _statusChip(visit.status),
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
                              // Left info column
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailField('Full Name', visit.visitorName),
                                    _buildDetailField('Phone Number', visit.visitorPhone),
                                    _buildDetailField('Company', visit.visitorCompany ?? '--'),
                                    _buildDetailField('Expected Duration', visit.expectedDuration ?? '--'),
                                    _buildDetailField('Notes', visit.notes ?? '--'),
                                  ],
                                ),
                              ),
                              // Right info column
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailField('Host Name', visit.hostName),
                                    _buildDetailField('Purpose of Visit', visit.purpose),
                                    _buildDetailField('Check-In Time', DateFormat('MMMM dd, yyyy - hh:mm a').format(visit.checkInTime)),
                                    _buildDetailField('Check-Out Time', visit.checkOutTime != null 
                                        ? DateFormat('MMMM dd, yyyy - hh:mm a').format(visit.checkOutTime!) 
                                        : '--'),
                                    _buildDetailField('Station ID', visit.stationId),
                                    if (visit.signatureB64 != null) ...[
                                      const SizedBox(height: 16),
                                      const Text('Visitor Signature', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade200),
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.grey.shade50,
                                        ),
                                        child: Image.memory(base64Decode(visit.signatureB64!), height: 80, fit: BoxFit.contain),
                                      ),
                                    ],
                                    if (visit.scannedIdUrl != null) ...[
                                      const SizedBox(height: 24),
                                      const Text('Scanned ID Document', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
                                      const SizedBox(height: 8),
                                      _buildScannedIdPreview(visit.scannedIdUrl!),
                                    ],
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
                      // Actions footer within Details
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
                              _showEditDialog(context, visit);
                            },
                            icon: const Icon(Icons.edit, size: 16),
                            label: const Text('Edit'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(color: Colors.blue),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Check-in / Out Action
                          if (visit.status == 'active')
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context); // Close details
                                _confirmCheckOut(context, visit);
                              },
                              icon: const Icon(Icons.logout, size: 16),
                              label: const Text('Check Out'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              ),
                            )
                          else
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context); // Close details
                                _confirmCheckIn(context, visit);
                              },
                              icon: const Icon(Icons.login, size: 16),
                              label: const Text('Check In Again'),
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
                              _confirmDelete(context, visit);
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

  Widget _buildScannedIdPreview(String url) {
    final bool isPdf = url.toLowerCase().contains('.pdf');

    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondary.withOpacity(0.08)),
      ),
      clipBehavior: Clip.antiAlias,
      child: isPdf
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 36),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => js.context.callMethod('open', [url, '_blank']),
                    icon: const Icon(Icons.open_in_new, size: 14),
                    label: const Text('Open PDF Document', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.broken_image_outlined, color: Colors.grey),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: FloatingActionButton.small(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    tooltip: 'Open in new tab',
                    onPressed: () => js.context.callMethod('open', [url, '_blank']),
                    child: const Icon(Icons.open_in_new, size: 14),
                  ),
                ),
              ],
            ),
    );
  }
}

final visitListProvider = StreamProvider<List<Visit>>((ref) {
  return ref.watch(visitRepositoryProvider).watchVisitHistory();
});

final _staffListProvider = StreamProvider<List<Staff>>((ref) {
  return ref.watch(staffRepositoryProvider).watchAllStaff();
});
