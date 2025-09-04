import 'package:flutter/material.dart';
import '../widgets/pill_option.dart';

class Step1BuyRent extends StatelessWidget {
  const Step1BuyRent({
    super.key,
    required this.selected,
    required this.onChanged,
  });
  final String? selected;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Are you looking to buy or rent a property?',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 18),
        PillOption(
          label: 'Rent',
          selected: selected == 'Rent',
          onTap: () => onChanged('Rent'),
        ),
        const SizedBox(height: 12),
        PillOption(
          label: 'Buy',
          selected: selected == 'Buy',
          onTap: () => onChanged('Buy'),
        ),
      ],
    );
  }
}
