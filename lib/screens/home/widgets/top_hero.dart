import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../theme/brand.dart';
import 'segmented_tabs.dart';
import 'buy_rent_switch.dart';
import 'search_with_fab.dart';

class TopHero extends StatelessWidget {
  const TopHero({
    super.key,
    required this.topTab,
    required this.onTabChanged,
    required this.intent,
    required this.onIntentChanged,
  });

  final int topTab;
  final ValueChanged<int> onTabChanged;
  final String intent;
  final ValueChanged<String> onIntentChanged;

  // Tweak these to taste
  static const double _imageHeight = 300; // taller background image
  static const double _cardHeight = 188; // fixed height for 50/50 overlap
  static const double _sidePadding = 16;

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final totalHeight = _imageHeight + (_cardHeight / 2) + 16;

    return SizedBox(
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background sky + skyline (NETWORK image)
          Container(
            height: _imageHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFEFF8F3), Colors.white],
              ),
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?q=80&w=1600&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          // Wordmark left + circular FontAwesome icon right
          Positioned(
            left: _sidePadding,
            right: _sidePadding,
            top: topPad + 12,
            child: Row(
              children: [
                Text(
                  'bayut',
                  style: TextStyle(
                    color: Brand.green,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    letterSpacing: .2,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Brand.borderLight),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    // Use any FA icon you prefer
                    child: FaIcon(
                      FontAwesomeIcons.houseChimney,
                      size: 16,
                      color: Brand.green,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Floating card — half inside image, half below
          Positioned(
            left: _sidePadding,
            right: _sidePadding,
            top: _imageHeight - (_cardHeight / 2),
            child: Material(
              // >>> Fix for “black corners”: give Material a rounded shape AND clip
              color: Colors.transparent,
              elevation: 6,
              shadowColor: Colors.black.withOpacity(.12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: _cardHeight),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Brand.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SegmentedTabs(
                        index: topTab,
                        labels: const [
                          'Properties',
                          'New Projects',
                          'Transactions',
                        ],
                        onChanged: onTabChanged,
                      ),
                      const SizedBox(height: 10),
                      BuyRentSwitch(value: intent, onChanged: onIntentChanged),
                      const SizedBox(height: 10),
                      const SearchWithFab(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
