import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/theme.dart';
import 'station_provider.dart';

class StationSetupScreen extends ConsumerStatefulWidget {
  const StationSetupScreen({super.key});

  @override
  ConsumerState<StationSetupScreen> createState() => _StationSetupScreenState();
}

class _StationSetupScreenState extends ConsumerState<StationSetupScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.settings, size: 64, color: AppColors.primary),
              const SizedBox(height: 24),
              const Text('Station Configuration', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text('Enter the unique Station ID for this reception stand.', textAlign: TextAlign.center),
              const SizedBox(height: 32),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Station ID',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. floor2-reception',
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Scan QR Code'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Scan QR Code'),
                        content: SizedBox(
                          width: 300,
                          height: 300,
                          child: MobileScanner(
                            onDetect: (capture) {
                              final List<Barcode> barcodes = capture.barcodes;
                              for (final barcode in barcodes) {
                                if (barcode.rawValue != null) {
                                  _controller.text = barcode.rawValue!;
                                  Navigator.of(context).pop();
                                  break;
                                }
                              }
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      ref.read(stationIdProvider.notifier).set(_controller.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Save Configuration'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

