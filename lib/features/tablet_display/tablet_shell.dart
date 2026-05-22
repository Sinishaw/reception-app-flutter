import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_provider.dart';
import 'idle_screen.dart';
import 'summary_screen.dart';
import 'badge_screen.dart';
import '../pairing/station_provider.dart';

import '../../shared/models/station.dart';

class TabletShell extends ConsumerWidget {
  const TabletShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stationId = ref.watch(stationIdProvider);
    
    if (stationId == null) {
      return const IdleScreen();
    }

    ref.listen<AsyncValue<ActiveSession?>>(activeSessionProvider, (previous, next) {
      if (next.hasValue) {
        final session = next.value;
        final localSessionId = ref.read(sessionIdProvider);
        final bool isSessionTerminated = session == null || session.screen == 'terminated';
        final bool isSessionIdMismatch = session != null && session.sessionId != localSessionId;

        if (isSessionTerminated || isSessionIdMismatch) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(stationIdProvider.notifier).clear();
            ref.read(assignedFloorProvider.notifier).clear();
            ref.read(sessionIdProvider.notifier).clear();
            ref.read(pairingTimeProvider.notifier).clear();
          });
        }
      }
    });

    final sessionAsync = ref.watch(activeSessionProvider);

    return sessionAsync.when(
      data: (session) {
        final screen = session?.screen ?? 'idle';
        
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildScreen(screen, session),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
    );
  }

  Widget _buildScreen(String screen, dynamic session) {
    switch (screen) {
      case 'idle':
        return const IdleScreen();
      case 'summary':
        return SummaryScreen(session: session);
      case 'badge':
        return BadgeScreen(session: session);
      default:
        return const IdleScreen();
    }
  }
}
