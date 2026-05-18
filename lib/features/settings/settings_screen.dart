import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/theme.dart';
import '../pairing/station_provider.dart';
import '../../shared/services/floor_service.dart';
import '../../shared/services/station_service.dart';
import '../../shared/repositories/providers.dart';
import '../../shared/models/station.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _stationIdController = TextEditingController();
  final _floorController = TextEditingController();

  String? _selectedStationId;
  String? _selectedFloor;

  @override
  void initState() {
    super.initState();
    // Initialize controller and local states with current state after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentId = ref.read(stationIdProvider);
      final currentFloor = ref.read(assignedFloorProvider);
      setState(() {
        _selectedStationId = currentId;
        _selectedFloor = currentFloor;
        if (currentId != null) {
          _stationIdController.text = currentId;
        }
        if (currentFloor != null) {
          _floorController.text = currentFloor;
        }
      });
    });

    _stationIdController.addListener(_onInputsChanged);
    _floorController.addListener(_onInputsChanged);
  }

  @override
  void dispose() {
    _stationIdController.dispose();
    _floorController.dispose();
    super.dispose();
  }

  void _onInputsChanged() {
    final stationText = _stationIdController.text.trim();
    final floorText = _floorController.text.trim();
    setState(() {
      _selectedStationId = stationText.isEmpty ? null : stationText;
      _selectedFloor = floorText.isEmpty ? null : floorText;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final stationId = ref.watch(stationIdProvider);
    final assignedFloor = ref.watch(assignedFloorProvider);

    final bool isFormValid = _selectedStationId != null && _selectedFloor != null;

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
                    if (stationId != null) ...[
                      // Active Session Mode
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Active Reception Session',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Station ID',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  stationId,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondary,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Assigned Floor',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  assignedFloor ?? 'Not Assigned',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Session Active Duration',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                StreamBuilder<int>(
                                  stream: Stream.periodic(const Duration(seconds: 1), (x) => x),
                                  builder: (context, snapshot) {
                                    final pairingTimeStr = ref.watch(pairingTimeProvider);
                                    if (pairingTimeStr == null) return const Text('--:--:--');
                                    
                                    final pairingTime = DateTime.tryParse(pairingTimeStr);
                                    if (pairingTime == null) return const Text('--:--:--');
                                    
                                    final diff = DateTime.now().difference(pairingTime);
                                    return Row(
                                      children: [
                                        const Icon(Icons.timer_outlined, color: Colors.green, size: 16),
                                        const SizedBox(width: 6),
                                        Text(
                                          _formatDuration(diff),
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      const Text(
                        'Scan this QR code from your tablet device camera to open and pair automatically:',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary),
                      ),
                      const SizedBox(height: 16),
                      Builder(builder: (context) {
                        final hostUrl = Uri.base.origin;
                        final qrData = '$hostUrl/?mode=tablet&stationId=$stationId';
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.secondary.withOpacity(0.08),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(24),
                            child: QrImageView(
                              data: qrData,
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              await ref.read(sessionRepositoryProvider).clearSession(stationId);
                              await ref.read(stationIdProvider.notifier).clear();
                              await ref.read(assignedFloorProvider.notifier).clear();
                              await ref.read(pairingTimeProvider.notifier).clear();
                              
                              setState(() {
                                _stationIdController.clear();
                                _floorController.clear();
                                _selectedStationId = null;
                                _selectedFloor = null;
                              });

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Session terminated and device pairing cleared successfully!'),
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
                          icon: const Icon(Icons.cancel_presentation_rounded, size: 20),
                          label: const Text('Terminate Active Session'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      // Create Session Mode
                      const Text(
                        'Create New Reception Session',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'To initialize a reception session, select a Station ID and Floor Assignment from the corporate directory.',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      
                      // Station ID Autocomplete
                      const Text('1. Station ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 8),
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) async {
                          return await StationService.fetchStations(textEditingValue.text);
                        },
                        onSelected: (String selection) {
                          setState(() {
                            _selectedStationId = selection;
                            _stationIdController.text = selection;
                          });
                        },
                        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                          if (controller.text.isEmpty && _selectedStationId != null) {
                            controller.text = _selectedStationId!;
                          }
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              labelText: 'Search & Select Station ID',
                              hintText: 'Type to search station directory...',
                              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: AppColors.surfaceContainerLow,
                            ),
                            onFieldSubmitted: (v) => onFieldSubmitted(),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      
                      // Floor Assignment Autocomplete
                      const Text('2. Floor Assignment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 8),
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) async {
                          return await FloorService.fetchFloors(textEditingValue.text);
                        },
                        onSelected: (String selection) {
                          setState(() {
                            _selectedFloor = selection;
                            _floorController.text = selection;
                          });
                        },
                        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                          if (controller.text.isEmpty && _selectedFloor != null) {
                            controller.text = _selectedFloor!;
                          }
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              labelText: 'Physical Floor Location',
                              hintText: 'Type to search floor directory...',
                              prefixIcon: const Icon(Icons.layers_rounded, color: AppColors.primary),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: AppColors.surfaceContainerLow,
                            ),
                            onFieldSubmitted: (v) => onFieldSubmitted(),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: isFormValid ? () async {
                            final stationVal = _selectedStationId!;
                            final floorVal = _selectedFloor!;
                            final now = DateTime.now().toIso8601String();

                            await ref.read(stationIdProvider.notifier).set(stationVal);
                            await ref.read(assignedFloorProvider.notifier).set(floorVal);
                            await ref.read(pairingTimeProvider.notifier).set(now);

                            try {
                              await ref.read(sessionRepositoryProvider).updateSession(
                                stationVal,
                                const ActiveSession(screen: 'idle'),
                              );
                            } catch (e) {
                              // Ignore
                            }

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Session created successfully for $stationVal on floor $floorVal!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } : null,
                          icon: const Icon(Icons.add_task_rounded, size: 20),
                          label: const Text('Create Session'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: isFormValid ? 4 : 0,
                          ),
                        ),
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
