import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme.dart';
import '../../shared/repositories/providers.dart';
import '../../shared/models/visit.dart';

class VisitLogScreen extends ConsumerWidget {
  const VisitLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitsAsync = ref.watch(visitListProvider);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Visit History', style: Theme.of(context).textTheme.headlineMedium),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download),
                label: const Text('Export to CSV'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search visitors, hosts, or company...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Card(
              child: visitsAsync.when(
                data: (visits) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Visitor')),
                      DataColumn(label: Text('Company')),
                      DataColumn(label: Text('Host')),
                      DataColumn(label: Text('Check-in')),
                      DataColumn(label: Text('Check-out')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows: visits.map((visit) => DataRow(
                      cells: [
                        DataCell(Text(visit.visitorName)),
                        DataCell(Text(visit.visitorCompany ?? '--')),
                        DataCell(Text(visit.hostName)),
                        DataCell(Text(DateFormat('MMM dd, hh:mm a').format(visit.checkInTime))),
                        DataCell(Text(visit.checkOutTime != null 
                            ? DateFormat('hh:mm a').format(visit.checkOutTime!) 
                            : '--')),
                        DataCell(_statusChip(visit.status)),
                      ],
                    )).toList(),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Center(child: Text('Error: $e')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    final isActive = status == 'active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: (isActive ? Colors.green : Colors.grey).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10, 
          color: isActive ? Colors.green : Colors.grey, 
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}

final visitListProvider = StreamProvider<List<Visit>>((ref) {
  return ref.watch(visitRepositoryProvider).watchVisitHistory();
});
