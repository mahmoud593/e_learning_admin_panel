
import 'package:e_learning_dathboard/admin_screens/admin_home/admin_home.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late AnimationController _rotateController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Initialize animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.bounceOut,
    ));

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotateController,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        // Start animations sequentially
        _slideController.forward();
        await Future.delayed(const Duration(milliseconds: 300));
        _scaleController.forward();
        await Future.delayed(const Duration(milliseconds: 200));
        _fadeController.forward();
        _rotateController.forward();

        // Navigate after animations complete
        Future.delayed(const Duration(seconds: 3), () {

          customPushReplacement(context, const AdminHome());

        });
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorManager.primary,
              ColorManager.primary.withOpacity(0.8),
              ColorManager.primary.withOpacity(0.9),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _rotateAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: BackgroundPatternPainter(
                      animation: _rotateAnimation.value,
                    ),
                  );
                },
              ),
            ),

            // Main content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Animated title
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width * 0.05,
                          vertical: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'How to easily get',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: ColorManager.white.withOpacity(0.9),
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.white.withOpacity(0.8),
                                ],
                              ).createShader(bounds),
                              child: Text(
                                'A+',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                            Text(
                              'with Dr. Mohamed Ismail',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.white.withOpacity(0.9),
                                letterSpacing: 0.8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),

                  // Animated profile image with enhanced design
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.35,
                        width: MediaQuery.sizeOf(context).height * 0.35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.9),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                              offset: const Offset(0, 10),
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: -5,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image(
                            image: const AssetImage("assets/images/dr.jpeg"),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: MediaQuery.sizeOf(context).height * 0.1,
                                  color: Colors.grey.shade600,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),

                  // Loading indicator
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.8),
                            ),
                            minHeight: 3,
                          ),
                        ),
                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                        Text(
                          'Loading Excellence...',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorManager.white.withOpacity(0.8),
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for background pattern
class BackgroundPatternPainter extends CustomPainter {
  final double animation;

  BackgroundPatternPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width * 0.8;

    // Draw animated concentric circles
    for (int i = 1; i <= 5; i++) {
      final radius = (maxRadius / 5) * i * (0.5 + 0.5 * animation);
      canvas.drawCircle(center, radius, paint);
    }

    // Draw floating dots
    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final angle = (i * 18) * (3.14159 / 180) + (animation * 2 * 3.14159);
      final radius = 100 + (i * 20);
      final x = center.dx + radius * 0.7 * (1 + 0.3 * animation) * (i.isEven ? 1 : -1) *
          (0.5 + 0.5 * animation);
      final y = center.dy + radius * 0.5 * (1 + 0.2 * animation) *
          (i.isOdd ? 1 : -1) * (0.3 + 0.7 * animation);

      if (x >= 0 && x <= size.width && y >= 0 && y <= size.height) {
        canvas.drawCircle(Offset(x, y), 2 + (2 * animation), dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant BackgroundPatternPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}