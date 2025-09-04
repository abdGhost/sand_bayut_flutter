import 'package:flutter/material.dart';
import '../../../theme/brand.dart';

class SegmentedTabs extends StatelessWidget {
  const SegmentedTabs({
    super.key,
    required this.index,
    required this.labels,
    required this.onChanged,
  });
  final int index;
  final List<String> labels;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAF9),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Brand.borderLight),
      ),
      child: Row(
        children: [
          for (int i = 0; i < labels.length; i++) ...[
            Expanded(
              child: InkWell(
                onTap: () => onChanged(i),
                borderRadius: BorderRadius.circular(22),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: index == i
                        ? Brand.green.withOpacity(.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: index == i ? Brand.green : Colors.transparent,
                      width: 1.2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      labels[i],
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: index == i
                            ? Brand.darkTeal
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (i != labels.length - 1) const SizedBox(width: 6),
          ],
        ],
      ),
    );
  }
}
