import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/theme.dart';
import '../../shared/models/station.dart';
import '../../shared/repositories/providers.dart';
import '../pairing/station_provider.dart';

class BadgeScreen extends ConsumerStatefulWidget {
  final ActiveSession session;
  const BadgeScreen({super.key, required this.session});

  @override
  ConsumerState<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends ConsumerState<BadgeScreen> {
  int _countdown = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 0) {
        _timer?.cancel();
        _resetSession();
      } else {
        if (mounted) {
          setState(() => _countdown--);
        }
      }
    });
  }

  Future<void> _resetSession() async {
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
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final payload = widget.session.badgePayload;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.green, size: 120),
              const SizedBox(height: 24),
              Text('Check-in Complete!', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text('Please take your visitor badge.', style: TextStyle(fontSize: 24, color: Colors.grey)),
              const SizedBox(height: 48),
              if (payload != null) ...[
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10)),
                    ],
                  ),
                  child: Column(
                    children: [
                      QrImageView(
                        data: payload.qrData,
                        version: QrVersions.auto,
                        size: 200.0,
                        foregroundColor: AppColors.primary,
                      ),
                      const SizedBox(height: 24),
                      Text(payload.visitorName, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      Text('Host: ${payload.hostName}', style: const TextStyle(fontSize: 20, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              Text('Returning to welcome screen in $_countdown seconds...', style: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic)),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
