import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signature/signature.dart';
import '../../core/theme.dart';
import '../../shared/models/station.dart';
import '../../shared/repositories/providers.dart';
import '../pairing/station_provider.dart';

class SummaryScreen extends ConsumerStatefulWidget {
  final ActiveSession session;
  const SummaryScreen({super.key, required this.session});

  @override
  ConsumerState<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends ConsumerState<SummaryScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: AppColors.onSurface,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onConfirm() async {
    if (_controller.isEmpty) return;

    final signature = await _controller.toPngBytes();
    if (signature != null) {
      final b64 = base64Encode(signature);
      final stationId = ref.read(stationIdProvider);
      if (stationId != null) {
        await ref.read(sessionRepositoryProvider).updateSession(
          stationId,
          widget.session.copyWith(
            status: 'signed',
            signatureB64: b64,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Confirm Your Details', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 32),
            _infoRow('Visitor', widget.session.visitorName ?? ''),
            _infoRow('Host', widget.session.hostName ?? ''),
            _infoRow('Purpose', widget.session.purpose ?? ''),
            const Spacer(),
            const Text('Please sign here:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Signature(
                  controller: _controller,
                  height: 200,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                TextButton(
                  onPressed: () => _controller.clear(),
                  child: const Text('Clear', style: TextStyle(fontSize: 20)),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Confirm & Sign', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
