// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:sands_bayt/screens/home/widgets/promo_carousel.dart';
import 'package:sands_bayt/screens/home/widgets/tru_broker_banner.dart';
import 'widgets/top_hero.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int topTab = 0; // 0: Properties, 1: New Projects, 2: Transactions
  String intent = 'Buy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: SizedBox.shrink(),
      ),
      body: CustomScrollView(
        slivers: [
          // Top header + tabs + Buy/Rent + search
          SliverToBoxAdapter(
            child: TopHero(
              topTab: topTab,
              onTabChanged: (i) => setState(() => topTab = i),
              intent: intent,
              onIntentChanged: (v) => setState(() => intent = v),
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
                    bgImageUrl: 'https://picsum.photos/seed/bayutgpt/1200/800',
                    bgAlignment: Alignment.centerRight,
                  ),
                  PromoCardData(
                    title: 'Mortgage Finder',
                    subtitle: 'Check rates and eligibility instantly',
                    bgImageUrl: 'https://picsum.photos/seed/mortgage/1200/800',
                  ),
                  PromoCardData(
                    title: 'Ask an Expert',
                    subtitle: 'Get advice from local specialists',
                    bgImageUrl: 'https://picsum.photos/seed/expert/1200/800',
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 400)),
        ],
      ),
    );
  }
}
