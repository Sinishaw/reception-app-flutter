import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../check_in/check_in_form.dart';
import '../dashboard/dashboard_screen.dart';
import '../visit_log/visit_log_screen.dart';
import '../appointments/appointments_screen.dart';
import '../settings/settings_screen.dart';
import '../pairing/station_provider.dart';
import '../../shared/repositories/providers.dart';

class ReceptionistShell extends ConsumerStatefulWidget {
  const ReceptionistShell({super.key});

  @override
  ConsumerState<ReceptionistShell> createState() => _ReceptionistShellState();
}

class _ReceptionistShellState extends ConsumerState<ReceptionistShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const VisitLogScreen(),
    const AppointmentsScreen(),
    const DashboardScreen(),
    const SettingsScreen(),
  ];

  final List<String> _titles = [
    'Visitors Log',
    'Expected Appointments',
    'Reception Dashboard',
    'System Settings',
  ];

  @override
  Widget build(BuildContext context) {
    final stationId = ref.watch(stationIdProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // 1. Sleek Modern Sidebar
          Container(
            width: 280,
            color: AppColors.surfaceContainerLow, // Premium Soft Warm Fine-Paper Sidebar Background
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Branding Header
                Padding(
                  padding: const EdgeInsets.only(left: 28, top: 48, right: 24, bottom: 36),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.secondary.withOpacity(0.1),
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'MMCY',
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              'CONCIERGE SYSTEM',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Navigation Items
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _buildSidebarItem(
                          index: 0,
                          icon: Icons.people_rounded,
                          label: 'Visitors',
                        ),
                        const SizedBox(height: 8),
                        _buildSidebarItem(
                          index: 1,
                          icon: Icons.calendar_today_rounded,
                          label: 'Appointments',
                        ),
                        const SizedBox(height: 8),
                        _buildSidebarItem(
                          index: 2,
                          icon: Icons.dashboard_rounded,
                          label: 'Dashboard',
                        ),
                        const SizedBox(height: 8),
                        _buildSidebarItem(
                          index: 3,
                          icon: Icons.settings_rounded,
                          label: 'Settings',
                        ),
                      ],
                    ),
                  ),
                ),
                // Footer / Kiosk Info Section
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.secondary.withOpacity(0.08),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Station Active',
                              style: TextStyle(
                                color: AppColors.secondary.withOpacity(0.7),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          stationId != null ? 'Front Desk - $stationId' : 'Front Desk - Main Lobby',
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ID: ${stationId ?? 'Not Paired'}',
                          style: TextStyle(
                            color: AppColors.secondary.withOpacity(0.5),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 2. Main Content & Premium Floating Header
          Expanded(
            child: Column(
              children: [
                // Custom Floating Header
                Container(
                  height: 96,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.surfaceContainerLow,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _titles[_selectedIndex],
                            style: const TextStyle(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Welcome back, administrator',
                            style: TextStyle(
                              color: AppColors.secondary.withOpacity(0.7),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // Header Actions (Digital Clock & Settings)
                      Row(
                        children: [
                          // Tablet Sync/Refresh Button
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.tablet_mac_rounded,
                                color: stationId != null ? Colors.green : Colors.grey,
                                size: 22,
                              ),
                              tooltip: 'Sync & Refresh Tablet',
                              onPressed: _syncTablet,
                            ),
                          ),
                          const SizedBox(width: 16),
                          _buildHeaderClock(),
                          const SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.notifications_none_rounded,
                                color: AppColors.secondary,
                                size: 22,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Active Screen
                Expanded(
                  child: _screens[_selectedIndex],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? AppColors.primary : Colors.transparent,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.secondary.withOpacity(0.7),
              size: 22,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.secondary.withOpacity(0.7),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _syncTablet() async {
    final stationId = ref.read(stationIdProvider);
    if (stationId == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please configure a Station ID first in Settings.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    try {
      // Force refresh the tablet by clearing the session to idle
      await ref.read(sessionRepositoryProvider).clearSession(stationId);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.sync_rounded, color: Colors.white),
                SizedBox(width: 12),
                Text('Tablet successfully synchronized & reset to idle screen!'),
              ],
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sync tablet: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildHeaderClock() {
    return StreamBuilder<DateTime>(
      stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, snapshot) {
        final now = snapshot.data ?? DateTime.now();
        final timeStr = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.access_time_rounded,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                timeStr,
                style: const TextStyle(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
