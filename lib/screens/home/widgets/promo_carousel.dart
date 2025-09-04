import 'package:flutter/material.dart';

class PromoCardData {
  const PromoCardData({
    required this.title,
    required this.subtitle,
    this.badge, // kept for compatibility (not used for style)
    this.cta,
    this.bgImageUrl, // optional background image
    this.bgAlignment = Alignment.centerRight,
  });

  final String title;
  final String subtitle;
  final String? badge;
  final String? cta;
  final String? bgImageUrl;
  final Alignment bgAlignment;
}

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key, required this.cards});
  final List<PromoCardData> cards;

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  // Make each page a bit narrower so the gap is visible
  final _controller = PageController(viewportFraction: .90);
  static const double _gap = 12; // space between cards
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    final hasCta = widget.cards.any((c) => (c.cta ?? '').isNotEmpty);
    final double cardHeight = hasCta ? 172 : 140;

    return Column(
      children: [
        SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: _controller,
            padEnds: false, // don't auto-pad ends
            clipBehavior: Clip.none, // let shadows spill into the gap
            physics: const BouncingScrollPhysics(),
            onPageChanged: (i) => setState(() => _i = i),
            itemCount: widget.cards.length,
            itemBuilder: (_, i) {
              final isFirst = i == 0;
              final isLast = i == widget.cards.length - 1;
              return Padding(
                // symmetric spacing between pages, none at the very ends
                padding: EdgeInsets.only(
                  left: isFirst ? 0 : _gap / 2,
                  right: isLast ? 0 : _gap / 2,
                ),
                child: _PromoCard(data: widget.cards[i], height: cardHeight),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int j = 0; j < widget.cards.length; j++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: j == _i
                      ? const Color(0xFF0B6B63)
                      : const Color(0xFFC7D5D1),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({required this.data, required this.height});
  final PromoCardData data;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      // soft outer shadow (not a border)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // BG image or mint blob fallback
              if ((data.bgImageUrl ?? '').isNotEmpty)
                Image.network(
                  data.bgImageUrl!,
                  fit: BoxFit.cover,
                  alignment: data.bgAlignment,
                  errorBuilder: (_, __, ___) => const _BlobBackground(),
                  loadingBuilder: (_, child, p) =>
                      p == null ? child : const _BlobBackground(),
                )
              else
                const _BlobBackground(),

              // Readability overlay (no edge “border”)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(184, 255, 255, 255),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.60], // fades out before the right edge
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Color(0xFF0B6B63),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              height: 1.25,
                              color: Colors.grey.shade800,
                              fontSize: 14,
                            ),
                          ),
                          if ((data.cta ?? '').isNotEmpty) ...[
                            const SizedBox(height: 14),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF0B6B63),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                data.cta!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Soft mint shapes that mimic the screenshot if image is missing
class _BlobBackground extends StatelessWidget {
  const _BlobBackground();
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: const Color(0xFFEAF6F3)),
        Positioned(
          right: -10,
          bottom: -8,
          child: Opacity(
            opacity: .9,
            child: SizedBox(
              width: 180,
              height: 120,
              child: CustomPaint(painter: _BlobPainter()),
            ),
          ),
        ),
      ],
    );
  }
}

class _BlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final mint = Paint()..color = const Color(0xFFD6ECE6);
    final mint2 = Paint()..color = const Color(0xFFCBE6DF);
    final r1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(20, 30, size.width * .75, size.height * .55),
      const Radius.circular(60),
    );
    final r2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(60, 10, size.width * .55, size.height * .45),
      const Radius.circular(40),
    );
    canvas.drawRRect(r1, mint);
    canvas.drawRRect(r2, mint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
