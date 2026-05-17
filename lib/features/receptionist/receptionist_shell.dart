import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../check_in/check_in_form.dart';
import '../dashboard/dashboard_screen.dart';
import '../visit_log/visit_log_screen.dart';
import '../appointments/appointments_screen.dart';
import '../settings/settings_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MMCY Reception System'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => setState(() => _selectedIndex = 3),
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) => setState(() => _selectedIndex = index),
            labelType: NavigationRailLabelType.all,
            backgroundColor: AppColors.primary,
            unselectedIconTheme: const IconThemeData(color: Colors.white70),
            selectedIconTheme: const IconThemeData(color: Colors.white),
            unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
            selectedLabelTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.people), label: Text('Visitors')),
              NavigationRailDestination(icon: Icon(Icons.calendar_today), label: Text('Appointments')),
              NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Dashboard')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Container(
              color: AppColors.background,
              child: _screens[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
