import 'package:flutter/material.dart';
import '../../theme/brand.dart';

class SegmentedProgress extends StatelessWidget {
  const SegmentedProgress({
    super.key,
    required this.current,
    required this.total,
  });
  final int current;
  final int total;
  @override
  Widget build(BuildContext context) {
    final segs = List.generate(total, (i) => i);
    return Row(
      children: [
        for (final i in segs) ...[
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: i <= current ? Brand.green : Brand.borderLight,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          if (i != total - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}
