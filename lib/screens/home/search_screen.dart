import 'package:flutter/material.dart';
import 'package:sands_bayt/screens/home/filter/filter_screen.dart';
import 'package:sands_bayt/theme/brand.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  // Data (sample)
  final List<String> _cities = const ['Dubai', 'Sharjah', 'Abu Dhabi'];
  final Map<String, List<String>> _areasByCity = const {
    'Dubai': ['Downtown Dubai', 'Business Bay', 'Dubai Marina'],
    'Sharjah': ['Tilal City', 'Masaar'],
    'Abu Dhabi': ['Al Reem Island', 'Yas Island'],
  };
  final Map<String, List<String>> _subsByArea = const {
    'Downtown Dubai': [
      'The Central Downtown Tower A',
      'The Central Downtown Tower B',
      'The Central Downtown Tower C',
      'The Central Downtown Tower D',
    ],
    'Business Bay': ['Executive Towers', 'Bay Square'],
    'Dubai Marina': ['Marina Gate', 'Emaar 6 Towers'],
    'Tilal City': ['Masaar', 'Kaya', 'Sarai'],
    'Masaar': ['Kaya', 'Sequoia', 'Sarai'],
    'Al Reem Island': ['Sun & Sky Towers', 'Shams Gate'],
    'Yas Island': ['Ansam', 'West Yas'],
  };

  final List<String> _recent = ['Dubai'];

  String? _selectedCity;
  String? _selectedArea;
  String? _selectedSub;

  String? get _currentLabel => _selectedSub ?? _selectedArea ?? _selectedCity;

  bool get _atCityLevel => _selectedCity == null;
  List<String> get _currentOptions {
    if (_atCityLevel) return _cities;
    if (_selectedArea == null) return _areasByCity[_selectedCity] ?? const [];
    return _subsByArea[_selectedArea] ?? const [];
  }

  String get _popularTitle {
    if (_selectedArea != null) return 'Popular Locations in ${_selectedArea!}';
    if (_selectedCity != null) return 'Popular Locations in ${_selectedCity!}';
    return 'Popular Locations';
  }

  void _tapOption(String label) {
    setState(() {
      if (_atCityLevel) {
        _selectedCity = label;
      } else if (_selectedArea == null) {
        _selectedArea = label;
      } else {
        _selectedSub = label;
      }
    });
  }

  void _clearOneLevel() {
    setState(() {
      if (_selectedSub != null) {
        _selectedSub = null;
      } else if (_selectedArea != null) {
        _selectedArea = null;
      } else if (_selectedCity != null) {
        _selectedCity = null;
      }
    });
  }

  void _resetAll() {
    setState(() {
      _controller.clear();
      _selectedCity = null;
      _selectedArea = null;
      _selectedSub = null;
    });
  }

  void _onSubmitQuery(String q) {
    final t = q.trim();
    if (t.isEmpty) return;
    if (!_recent.contains(t)) setState(() => _recent.insert(0, t));
  }

  void _goToFilterScreen() {
    // You can pass filters if needed; keeping navigation simple for now.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FilterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Brand.scaffold,
      body: SafeArea(
        child: Column(
          children: [
            // close + search
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 24,
                      color: Brand.textDark,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _SearchField(
                      controller: _controller,
                      onSubmitted: _onSubmitQuery,
                    ),
                  ),
                ],
              ),
            ),

            // current selection (one chip)
            if (_currentLabel != null)
              Container(
                width: double.infinity,
                color: Brand.lightTealBg,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 6),
                    InputChip(
                      backgroundColor: Colors.white,
                      // pill shape + subtle border
                      shape: const StadiumBorder(),
                      side: const BorderSide(
                        color: Brand.borderLight,
                        width: 1,
                      ),
                      labelPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Text(
                        _currentLabel!,
                        style: const TextStyle(color: Brand.textDark),
                      ),
                      deleteIconColor: Brand.textDark,
                      onDeleted: _clearOneLevel,
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 8),

            // list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                children: [
                  const _SectionHeader(
                    icon: Icons.history_rounded,
                    title: 'Recently Searched',
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _recent
                        .map(
                          (r) => _Pill(
                            label: r,
                            onTap: () {
                              if (_cities.contains(r)) {
                                setState(() {
                                  _selectedCity = r;
                                  _selectedArea = null;
                                  _selectedSub = null;
                                });
                              } else {
                                _controller.text = r;
                              }
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    height: 32,
                    thickness: 1,
                    color: Brand.borderLight,
                  ),

                  _SectionHeader(
                    icon: Icons.trending_up_rounded,
                    title: _popularTitle,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _currentOptions
                        .map((p) => _Pill(label: p, onTap: () => _tapOption(p)))
                        .toList(),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),

            // bottom buttons
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(
                color: Brand.cardLight,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    offset: Offset(0, -2),
                    color: Color(0x11000000),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Brand.borderLight,
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        foregroundColor: Brand.textDark,
                      ),
                      onPressed: _resetAll,
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Brand.darkTeal,
                        foregroundColor: Brand.textOnPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      onPressed: _goToFilterScreen,
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Search textfield with unified brand accents
class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onSubmitted});
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      style: const TextStyle(color: Brand.textDark),
      decoration: InputDecoration(
        hintText: 'Search for a locality, area or city',
        hintStyle: const TextStyle(color: Brand.textMute),
        filled: true,
        fillColor: Brand.fieldBg,
        prefixIcon: const Icon(Icons.search_rounded, color: Brand.textMute),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Brand.borderLight, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Brand.green, // subtle green focus like screenshot
            width: 1.4,
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: Brand.textDark,
    );
    return Row(
      children: [
        Icon(icon, color: Brand.textDark),
        const SizedBox(width: 10),
        Text(title, style: style),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Brand.fieldBg,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Brand.borderLight, width: 1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Brand.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
