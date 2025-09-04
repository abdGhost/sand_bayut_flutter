import 'package:flutter/material.dart';
import '../../theme/brand.dart';

class PillOption extends StatelessWidget {
  const PillOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? Brand.lightTealBg : Colors.white;
    final border = selected ? Brand.green : Brand.borderLight;
    final color = selected ? Brand.darkTeal : const Color(0xFF6B7280);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border, width: 1.4),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w700, color: color),
          ),
        ),
      ),
    );
  }
}
