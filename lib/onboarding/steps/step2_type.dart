import 'package:flutter/material.dart';
import '../widgets/scope_tabs.dart';
import '../widgets/icon_grid.dart';
import '../data/icon_options.dart';

class Step2Type extends StatelessWidget {
  const Step2Type({
    super.key,
    required this.scope,
    required this.selected,
    required this.onScopeChanged,
    required this.onTypeChanged,
  });
  final String scope;
  final String? selected;
  final ValueChanged<String> onScopeChanged;
  final ValueChanged<String> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    final opts = scope == 'Residential'
        ? residentialOptions
        : commercialOptions;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What type of property are you looking for?',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        ScopeTabs(scope: scope, onChanged: onScopeChanged),
        const SizedBox(height: 10),
        Expanded(
          child: IconGrid(
            options: opts,
            selected: selected,
            onSelect: onTypeChanged,
          ),
        ),
      ],
    );
  }
}
