import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme.dart';
import 'features/receptionist/receptionist_shell.dart';
import 'features/tablet_display/tablet_shell.dart';
import 'features/pairing/station_provider.dart';

import 'package:flutter/services.dart';

import 'features/notifications/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

  final prefs = await SharedPreferences.getInstance();

  if (!kUseMockFirestore) {
    // In real mode, initialize Firebase
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDJuWH5WAEpM85VUGIO8vo66tmoNGY23q8",
        appId: "1:892317828832:web:f7c100f12e75ee4de0b285",
        messagingSenderId: "892317828832",
        projectId: "reception-desk-1c9d0",
        authDomain: "reception-desk-1c9d0.firebaseapp.com",
        storageBucket: "reception-desk-1c9d0.firebasestorage.app",
        measurementId: "G-6X3VTZPDKG",
      ),
    );
  }

  String appMode = const String.fromEnvironment('APP_MODE', defaultValue: '');
  if (appMode.isEmpty) {
    appMode = 'receptionist';
    // Use Uri.base for web URL parameters
    final uri = Uri.base;
    if (uri.queryParameters['mode'] == 'tablet') {
      appMode = 'tablet';
      if (uri.queryParameters.containsKey('stationId')) {
        await prefs.setString('station_id', uri.queryParameters['stationId']!);
        if (uri.queryParameters.containsKey('floor')) {
          await prefs.setString('assigned_floor', uri.queryParameters['floor']!);
        }
        if (uri.queryParameters.containsKey('sessionId')) {
          await prefs.setString('session_id', uri.queryParameters['sessionId']!);
        }
        // Clear stationId from URL to prevent automatic re-pairing on page refresh
        SystemNavigator.routeInformationUpdated(
          uri: Uri.parse('/?mode=tablet'),
          replace: true,
        );
      }
    }
  }
  
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: ReceptionApp(mode: appMode),
    ),
  );
}

class ReceptionApp extends StatelessWidget {
  final String mode;
  const ReceptionApp({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MMCY Reception System',
      theme: mode == 'tablet' ? AppTheme.tablet : AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: mode == 'tablet' ? const TabletShell() : const ReceptionistShell(),
    );
  }
}
