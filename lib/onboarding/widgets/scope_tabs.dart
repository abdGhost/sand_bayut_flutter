import 'package:flutter/material.dart';
import '../../theme/brand.dart';

class ScopeTabs extends StatelessWidget {
  const ScopeTabs({super.key, required this.scope, required this.onChanged});
  final String scope;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    Widget tab(String lbl) {
      final active = scope == lbl;
      return Expanded(
        child: InkWell(
          onTap: () => onChanged(lbl),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: active ? Brand.lightTealBg : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: active ? Brand.green : Brand.borderLight,
              ),
            ),
            child: Center(
              child: Text(
                lbl,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: active ? Brand.darkTeal : const Color(0xFF6B7280),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        tab('Residential'),
        const SizedBox(width: 10),
        tab('Commercial'),
      ],
    );
  }
}
