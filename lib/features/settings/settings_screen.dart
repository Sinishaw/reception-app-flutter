import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/theme.dart';
import '../pairing/station_provider.dart';
import '../../shared/services/floor_service.dart';
import '../../shared/repositories/providers.dart';

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
    final assignedFloor = ref.watch(assignedFloorProvider);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
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
                      Row(
                        children: [
                          const Icon(Icons.tablet_android_rounded, color: AppColors.secondary),
                          const SizedBox(width: 12),
                          const Text(
                            'Active Tablet Remote Session Control:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary),
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                await ref.read(sessionRepositoryProvider).clearSession(stationId);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Active tablet session terminated successfully. Tablet has returned to idle.'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Failed to terminate session: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            icon: const Icon(Icons.cancel_presentation_rounded, size: 18),
                            label: const Text('Terminate Active Session'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            ),
                          ),
                        ],
                      ),
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
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text('Floor Assignment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Assign the physical floor location of this station (e.g., Floor 2, Penthouse). This is retrieved asynchronously from the corporate database.'),
                    const SizedBox(height: 16),
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) async {
                        return await FloorService.fetchFloors(textEditingValue.text);
                      },
                      onSelected: (String selection) async {
                        await ref.read(assignedFloorProvider.notifier).set(selection);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Station floor set to $selection')),
                          );
                        }
                      },
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        if (controller.text.isEmpty && assignedFloor != null) {
                          controller.text = assignedFloor;
                        }
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: 'Physical Floor Location',
                            hintText: 'Type to search floor directory...',
                            prefixIcon: const Icon(Icons.layers_rounded, color: AppColors.primary),
                            suffixIcon: const Icon(Icons.arrow_drop_down_rounded, color: AppColors.secondary),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: AppColors.surfaceContainerLow,
                          ),
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
                              width: 400, // Matches the textfield bounds
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
                    if (assignedFloor != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Currently assigned: $assignedFloor',
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () async {
                              await ref.read(assignedFloorProvider.notifier).clear();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Floor assignment cleared')),
                                );
                              }
                            },
                            icon: const Icon(Icons.clear_rounded, size: 16, color: Colors.redAccent),
                            label: const Text('Clear Floor', style: TextStyle(color: Colors.redAccent)),
                          ),
                        ],
                      ),
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
      ),
    );
  }
}
