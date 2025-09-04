import 'package:flutter/material.dart';
import '../data/popular_cities.dart';
import '../../theme/brand.dart';

class Step3Locations extends StatelessWidget {
  const Step3Locations({
    super.key,
    required this.selectedAreas,
    required this.onToggleArea,
  });
  final Set<String> selectedAreas;
  final ValueChanged<String> onToggleArea;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Which areas are you interested in?',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        Text(
          'You can choose multiple preferred locations',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF6B7280)),
        ),
        const SizedBox(height: 12),
        const TextField(
          decoration: InputDecoration(
            hintText: 'Search for a locality, area or city',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Popular Locations',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final city in popularCities)
              ChoiceChip(
                label: Text(city),
                selected: selectedAreas.contains(city),
                onSelected: (_) => onToggleArea(city),
                selectedColor: Brand.lightTealBg,
                side: const BorderSide(color: Brand.borderLight),
                labelStyle: TextStyle(
                  color: selectedAreas.contains(city)
                      ? Brand.darkTeal
                      : const Color(0xFF111827),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
