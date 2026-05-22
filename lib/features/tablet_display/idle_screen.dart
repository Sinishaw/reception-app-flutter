import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../pairing/station_provider.dart';
import '../pairing/station_setup_screen.dart';

class IdleScreen extends ConsumerStatefulWidget {
  const IdleScreen({super.key});

  @override
  ConsumerState<IdleScreen> createState() => _IdleScreenState();
}

class _IdleScreenState extends ConsumerState<IdleScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _blurAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _blurAnimation = Tween<double>(begin: 8.0, end: 24.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stationId = ref.watch(stationIdProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background ambient gradient glowing behind
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    AppColors.surfaceContainerLow.withOpacity(0.4),
                    AppColors.background,
                  ],
                ),
              ),
            ),
          ),
          
          // Subtle pairings settings button at top right
          Positioned(
            top: 24,
            right: 24,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.secondary,
                  size: 20,
                ),
                tooltip: 'Pairing Setup',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const StationSetupScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated MMCY Logo Emblem (Styled as an elegant rounded pill card to perfectly fit the wide logo aspect ratio)
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 260,
                        height: 110,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.12),
                              blurRadius: _blurAnimation.value,
                              spreadRadius: _blurAnimation.value * 0.2,
                              offset: const Offset(0, 4),
                            ),
                            BoxShadow(
                              color: AppColors.secondary.withOpacity(0.04),
                              blurRadius: _blurAnimation.value * 0.5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            child: Image.asset(
                              'assets/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 48),
                
                // Welcome tag
                Text(
                  stationId != null ? 'Welcome to MMCY' : 'No active session or link device',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Animated micro-fading assistant text
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _opacityAnimation.value,
                      child: Text(
                        stationId != null
                            ? 'Please wait for the receptionist to assist you.'
                            : 'Please pair this tablet in Settings on the main Reception Desk.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.secondary.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 100),
                
                // Date tag
                Text(
                  DateTime.now().toString().split(' ')[0], // Simple date
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.secondary.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // Connected Station ID Pill Badge
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.secondary.withOpacity(0.08),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: stationId != null ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      stationId != null ? 'Station ID: $stationId' : 'Not Connected',
                      style: TextStyle(
                        color: AppColors.secondary.withOpacity(0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
