import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/theme.dart';
import '../pairing/station_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _stationIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controller with current state after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentId = ref.read(stationIdProvider);
      if (currentId != null) {
        _stationIdController.text = currentId;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final stationId = ref.watch(stationIdProvider);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 32),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Device Pairing', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text('Enter a Station ID to link this Receptionist App with a Tablet App. They must both use the same ID.'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _stationIdController,
                          decoration: const InputDecoration(
                            labelText: 'Station ID (e.g., floor2-reception)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () async {
                          final id = _stationIdController.text.trim();
                          if (id.isNotEmpty) {
                            await ref.read(stationIdProvider.notifier).set(id);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Station ID saved successfully')),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        child: const Text('Save'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () async {
                          await ref.read(stationIdProvider.notifier).clear();
                          _stationIdController.clear();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Station ID cleared')),
                            );
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (stationId != null) ...[
                    Text('Current Station ID: $stationId', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    const Text('Scan this QR code from your phone/tablet camera to open the app and pair automatically:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Builder(builder: (context) {
                      final hostUrl = Uri.base.origin;
                      final qrData = '$hostUrl/?mode=tablet&stationId=$stationId';
                      return Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(16),
                        child: QrImageView(
                          data: qrData,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      );
                    }),
                  ],
                ],

              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('System Configuration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Database Connection'),
                    subtitle: Text(kUseMockFirestore ? 'Mock Mode (Local)' : 'Live Firebase Mode'),
                    leading: Icon(
                      kUseMockFirestore ? Icons.storage : Icons.cloud_done,
                      color: kUseMockFirestore ? Colors.orange : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
