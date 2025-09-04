import 'dart:math' show pow;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:sands_bayt/screens/home/search_screen.dart';
import 'package:sands_bayt/screens/home/widgets/promo_carousel.dart';
import 'package:sands_bayt/screens/home/widgets/tru_broker_banner.dart';
import 'widgets/top_hero.dart';
import 'widgets/search_with_fab.dart';
import '../../theme/brand.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int topTab = 0; // 0: Properties, 1: New Projects, 2: Transactions
  String intent = 'Buy';

  final _scroll = ScrollController();
  final GlobalKey _heroSearchKey = GlobalKey();

  double _stickyOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleScroll());
  }

  @override
  void dispose() {
    _scroll.removeListener(_handleScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final ctx = _heroSearchKey.currentContext;
    if (ctx == null) return;

    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;

    final pos = box.localToGlobal(Offset.zero);

    final safeTop = MediaQuery.of(context).padding.top;
    final stickyY = safeTop + 8;
    const fadeLength = 36.0; // faster fade (shorter distance)

    final distance = (pos.dy - stickyY);
    final raw = 1 - (distance / fadeLength);
    final clamped = raw.clamp(0.0, 1.0).toDouble();

    // Non-linear ramp so it reaches higher opacity earlier
    final eased = pow(clamped, 0.7).toDouble();

    if ((eased - _stickyOpacity).abs() > 0.01) {
      setState(() => _stickyOpacity = eased);
    }
  }

  // ⬇️ One place to handle navigation to the search page
  void _openSearch({String? initialQuery}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SearchScreen(
          initialQuery: initialQuery ?? '',
          intent: intent,
          topTab: topTab,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final safeTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: SizedBox.shrink(),
      ),
      body: Stack(
        children: [
          // Main scroll
          CustomScrollView(
            controller: _scroll,
            slivers: [
              // Top header + tabs + Buy/Rent + search
              SliverToBoxAdapter(
                child: TopHero(
                  topTab: topTab,
                  onTabChanged: (i) => setState(() => topTab = i),
                  intent: intent,
                  onIntentChanged: (v) => setState(() => intent = v),
                  stickyAnchorKey: _heroSearchKey, // anchor to track
                  onSearchTap: () =>
                      _openSearch(), // ⬅️ open search on hero tap
                ),
              ),

              // TruBroker agent banner (dark card)
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                sliver: SliverToBoxAdapter(child: TruBrokerBanner()),
              ),

              // BayutGPT promo carousel (light card + dots)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                sliver: SliverToBoxAdapter(
                  child: PromoCarousel(
                    cards: const [
                      PromoCardData(
                        title: 'BayutGPT',
                        subtitle: 'Your trusted AI assistant for UAE property!',
                        cta: 'Start Chatting',
                        bgImageUrl:
                            'https://picsum.photos/seed/bayutgpt/1200/800',
                        bgAlignment: Alignment.centerRight,
                      ),
                      PromoCardData(
                        title: 'Mortgage Finder',
                        subtitle: 'Check rates and eligibility instantly',
                        bgImageUrl:
                            'https://picsum.photos/seed/mortgage/1200/800',
                      ),
                      PromoCardData(
                        title: 'Ask an Expert',
                        subtitle: 'Get advice from local specialists',
                        bgImageUrl:
                            'https://picsum.photos/seed/expert/1200/800',
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 400)),
            ],
          ),

          // Sticky full-bleed white bar + search (solid plate, no visible top arc)
          Stack(
            children: [
              // 1) FULL-WIDTH WHITE BACKPLATE
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  ignoring: true,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 60),
                    curve: Curves.easeOut,
                    height: lerpDouble(
                      0,
                      safeTop + 8 + 72, // status bar + spacing + search approx
                      _stickyOpacity,
                    )!,
                    color: Colors.white,
                  ),
                ),
              ),

              // 2) STICKY SEARCH CARD
              Positioned(
                left: 16,
                right: 16,
                top: safeTop + 8,
                child: Stack(
                  children: [
                    if (_stickyOpacity > 0.02)
                      Material(
                        elevation: 10 * _stickyOpacity,
                        shadowColor: Colors.black.withOpacity(.12),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: const Border(
                              left: BorderSide.none,
                              right: BorderSide.none,
                              bottom: BorderSide.none,
                              top: BorderSide
                                  .none, // ✅ no hairline border is painted
                            ),
                          ),
                        ),
                      ),
                    IgnorePointer(
                      ignoring: _stickyOpacity <= 0.02,
                      child: Opacity(
                        opacity: _stickyOpacity,
                        child: Transform.translate(
                          offset: Offset(0, (1 - _stickyOpacity) * 6),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                            child: SearchWithFab(
                              // ⬇️ open search on sticky tap or FAB tap or keyboard submit
                              readOnly: true,
                              onTap: _openSearch,
                              onFabTap: _openSearch,
                              onSubmitted: (q) => _openSearch(initialQuery: q),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 3) FOREGROUND TOP MASK (covers any shadow bleed above the card)
              if (_stickyOpacity > 0.02)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: safeTop + 8, // exactly above the card
                  child: const IgnorePointer(
                    ignoring: true,
                    child: ColoredBox(color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
