import 'package:flutter/material.dart';
import '../../theme/brand.dart';

class IconGridOption {
  const IconGridOption(this.icon, this.label);
  final IconData icon;
  final String label;
}

typedef IconGridOptions = List<IconGridOption>;

class IconGrid extends StatelessWidget {
  const IconGrid({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelect,
  });
  final IconGridOptions options;
  final String? selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 18,
        crossAxisSpacing: 12,
        childAspectRatio: .75,
      ),
      itemCount: options.length,
      itemBuilder: (_, i) {
        final o = options[i];
        final active = selected == o.label;
        return Column(
          children: [
            InkWell(
              onTap: () => onSelect(o.label),
              borderRadius: BorderRadius.circular(999),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: active ? Brand.lightTealBg : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: active ? Brand.green : Brand.borderLight,
                    width: 1.3,
                  ),
                ),
                child: Icon(
                  o.icon,
                  size: 28,
                  color: active ? Brand.darkTeal : const Color(0xFF9CA3AF),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              o.label,
              style: TextStyle(
                color: active ? Brand.darkTeal : const Color(0xFF6B7280),
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}
