import 'package:flutter/material.dart';

class TruBrokerBanner extends StatelessWidget {
  const TruBrokerBanner({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(.12),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0B3E3E), Color(0xFF0D5A56)],
            ),
          ),
          child: Stack(
            children: [
              // background waves
              Positioned.fill(
                child: IgnorePointer(
                  child: Opacity(
                    opacity: .18,
                    child: CustomPaint(painter: _WavesPainter()),
                  ),
                ),
              ),

              // chevron centered relative to entire card
              const Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              // main content
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // left text
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.06),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: Colors.white30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'TruBroker™',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE11D48),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: const Text(
                                  'NEW',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Find trusted agents awarded for their\nexcellent performance',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            height: 1.25,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // right: overlapping avatars (as before)
                  Padding(
                    // keep them clear of the chevron on the far right
                    padding: const EdgeInsets.only(right: 40),
                    child: SizedBox(
                      width: 106,
                      height: 64,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 0,
                            top: 8,
                            child: _avatar(
                              'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=256&auto=format&fit=crop',
                            ),
                          ),
                          Positioned(
                            left: 24,
                            top: 0,
                            child: _avatar(
                              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=256&auto=format&fit=crop',
                            ),
                          ),
                          Positioned(
                            left: 48,
                            top: 8,
                            child: _avatar(
                              'https://images.unsplash.com/photo-1527980965255-d3b416303d12?q=80&w=256&auto=format&fit=crop',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatar(String url) => Container(
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: CircleAvatar(backgroundImage: NetworkImage(url)),
  );
}

class _WavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..color = Colors.white.withOpacity(.10);
    for (int i = 0; i < 3; i++) {
      final dy = size.height * (.58 + i * .16);
      final path = Path()
        ..moveTo(0, dy)
        ..cubicTo(
          size.width * .22,
          dy - 18,
          size.width * .52,
          dy + 12,
          size.width,
          dy - 6,
        );
      canvas.drawPath(path, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
