import 'package:flutter/material.dart';
import '../theme/brand.dart';
import 'steps/step1_buy_rent.dart';
import 'steps/step2_type.dart';
import 'steps/step3_locations.dart';
import 'widgets/segmented_progress.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int step = 0; // 0..2

  String? intent; // Rent / Buy
  String scope = 'Residential';
  String? propType;
  final Set<String> areas = {};

  void _next() {
    if (step == 0 && intent == null) {
      _toast('Please select Rent or Buy');
      return;
    }
    if (step == 1 && propType == null) {
      _toast('Please choose a property type');
      return;
    }
    if (step < 2) setState(() => step++);
  }

  void _skip() {
    if (step < 2) setState(() => step++);
  }

  void _back() {
    if (step > 0) setState(() => step--);
  }

  void _toast(String m) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: AppBar(
        leading: step == 0
            ? const SizedBox()
            : IconButton(icon: const Icon(Icons.arrow_back), onPressed: _back),
        titleSpacing: 0,
        title: SegmentedProgress(current: step, total: 3),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + insets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildStep()),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _skip,
                    child: const Text('Skip'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: step == 2 ? _showResults : _next,
                    child: Text(step == 2 ? 'Show 10,659 properties' : 'Next'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (step) {
      case 0:
        return Step1BuyRent(
          selected: intent,
          onChanged: (v) => setState(() => intent = v),
        );
      case 1:
        return Step2Type(
          scope: scope,
          selected: propType,
          onScopeChanged: (v) => setState(() {
            scope = v;
            propType = null;
          }),
          onTypeChanged: (v) => setState(() => propType = v),
        );
      default:
        return Step3Locations(
          selectedAreas: areas,
          onToggleArea: (city) => setState(() {
            areas.contains(city) ? areas.remove(city) : areas.add(city);
          }),
        );
    }
  }

  void _showResults() {
    // TODO: Navigate to your results screen with selections
    // For now, just show a summary toast
    final txt =
        'Intent: $intent\nScope: $scope\nType: $propType\nAreas: ${areas.join(', ')}';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Selections'),
        content: Text(txt),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
