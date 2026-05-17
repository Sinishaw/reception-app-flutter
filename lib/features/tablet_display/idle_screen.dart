import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../pairing/station_provider.dart';

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
          
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated MMCY Logo Emblem
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          shape: BoxShape.circle,
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
                          child: CustomPaint(
                            size: const Size(80, 80),
                            painter: _MmcyLogoPainter(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 36),
                
                // Styled Brand Typography
                const Text(
                  'MMCY',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Welcome tag
                Text(
                  'Welcome to MMCY',
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
                        'Please wait for the receptionist to assist you.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.secondary.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 120),
                
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
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      stationId != null ? 'Station ID: $stationId' : 'Station: Pairing Needed',
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

// Custom Painter to render a sharp, vector-based geometric MMCY abstract monogram logo!
class _MmcyLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintOrange = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final paintNavy = Paint()
      ..color = AppColors.secondary
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Draw the stylized MMCY abstract logo mark
    final double barWidth = size.width * 0.18;
    final double height = size.height * 0.65;

    // Left Bar (Navy)
    final RRect leftBar = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.15,
        size.height * 0.25,
        barWidth,
        height * 0.8,
      ),
      Radius.circular(barWidth / 2),
    );
    canvas.drawRRect(leftBar, paintNavy);

    // Center-left link arch / diagonal
    final Path centerLeftLink = Path()
      ..moveTo(size.width * 0.24, size.height * 0.25)
      ..cubicTo(
        size.width * 0.3,
        size.height * 0.1,
        size.width * 0.45,
        size.height * 0.1,
        size.width * 0.5,
        size.height * 0.35,
      )
      ..lineTo(size.width * 0.5, size.height * 0.5)
      ..lineTo(size.width * 0.32, size.height * 0.5)
      ..close();
    canvas.drawPath(centerLeftLink, paintOrange);

    // Center Bar (Orange)
    final RRect centerBar = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.41,
        size.height * 0.15,
        barWidth,
        height * 0.9,
      ),
      Radius.circular(barWidth / 2),
    );
    canvas.drawRRect(centerBar, paintOrange);

    // Center-right link arch / diagonal
    final Path centerRightLink = Path()
      ..moveTo(size.width * 0.5, size.height * 0.15)
      ..cubicTo(
        size.width * 0.55,
        size.height * 0.05,
        size.width * 0.7,
        size.height * 0.05,
        size.width * 0.76,
        size.height * 0.25,
      )
      ..lineTo(size.width * 0.76, size.height * 0.5)
      ..lineTo(size.width * 0.58, size.height * 0.5)
      ..close();
    canvas.drawPath(centerRightLink, paintNavy);

    // Right Bar (Navy)
    final RRect rightBar = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.67,
        size.height * 0.25,
        barWidth,
        height * 0.8,
      ),
      Radius.circular(barWidth / 2),
    );
    canvas.drawRRect(rightBar, paintNavy);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
