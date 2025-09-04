import 'package:flutter/material.dart';
import '../../../theme/brand.dart';

class BuyRentSwitch extends StatelessWidget {
  const BuyRentSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value; // 'Buy' or 'Rent'
  final ValueChanged<String> onChanged;

  static const _h = 44.0;
  static const _pad = 4.0;
  static const _radius = 12.0;
  static const _innerRadius = 10.0;
  static const _dur = Duration(milliseconds: 180);

  @override
  Widget build(BuildContext context) {
    final isBuy = value == 'Buy';

    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_radius),
        child: SizedBox(
          height: _h,
          child: Stack(
            children: [
              // Track
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAF9),
                  borderRadius: BorderRadius.circular(_radius),
                  border: Border.all(color: Brand.borderLight),
                ),
              ),

              // Sliding highlight (exact half width)
              Padding(
                padding: const EdgeInsets.all(_pad),
                child: AnimatedAlign(
                  duration: _dur,
                  curve: Curves.easeOutCubic,
                  alignment: isBuy
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 1,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(_innerRadius),
                        border: Border.all(color: Brand.green, width: 1.2),
                      ),
                    ),
                  ),
                ),
              ),

              // Tap targets + labels (on top)
              Row(
                children: [
                  _segment(
                    label: 'Buy',
                    active: isBuy,
                    onTap: () => onChanged('Buy'),
                  ),
                  _gap(),
                  _segment(
                    label: 'Rent',
                    active: !isBuy,
                    onTap: () => onChanged('Rent'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gap() =>
      const SizedBox.shrink(); // visual gap handled by highlight padding

  Widget _segment({
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        // no splash to avoid visual jitter
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: _dur,
            curve: Curves.easeOutCubic,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: active ? Brand.darkTeal : const Color(0xFF6B7280),
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
