import 'package:flutter/material.dart';
import '../onboarding/onboarding_flow.dart';
import '../theme/brand.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingFlow()),
      );
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: CurvedAnimation(parent: _c, curve: Curves.easeOutBack),
              child: Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: Brand.green.withOpacity(.12),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Brand.green.withOpacity(.25)),
                ),
                child: const Icon(
                  Icons.home_work_rounded,
                  color: Brand.green,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Sands Bayt',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              "Find homes you'll love in the UAE",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
    );
  }
}
