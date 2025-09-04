import 'package:flutter/material.dart';
import 'package:sands_bayt/theme/brand.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Top tabs
  int _topTab = 0; // 0: Properties, 1: New Projects
  int _intent = 0; // 0: Buy, 1: Rent

  // Location
  final TextEditingController _searchCtrl = TextEditingController();
  bool _byCommute = false;
  final List<_LocationTag> _selectedLocations = [
    _LocationTag('The Central Downtown Tower C', meta: 'Off-Plan'),
  ];

  // Completion status
  int _completion = 0; // 0 All, 1 Ready, 2 Off-Plan

  // Property type segment + cards
  int _propSegment = 0; // 0 Residential, 1 Commercial
  String? _selectedType = 'Villa';

  // Result count (plug in your real logic later)
  int _resultsCount = 0;

  void _recount() {
    // TODO: replace with your real filter → count logic
    setState(() {
      _resultsCount = 0;
    });
  }

  void _resetAll() {
    setState(() {
      _topTab = 0;
      _intent = 0;
      _byCommute = false;
      _searchCtrl.clear();
      _selectedLocations
        ..clear()
        ..add(_LocationTag('The Central Downtown Tower C', meta: 'Off-Plan'));
      _completion = 0;
      _propSegment = 0;
      _selectedType = 'Villa';
      _resultsCount = 0;
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                _Section(
                  child: _SegmentedTwo(
                    left: 'Properties',
                    right: 'New Projects',
                    index: _topTab,
                    onChanged: (i) {
                      setState(() => _topTab = i);
                      _recount();
                    },
                  ),
                ),

                _Section(
                  child: _SegmentedTwo(
                    left: 'Buy',
                    right: 'Rent',
                    index: _intent,
                    onChanged: (i) {
                      setState(() => _intent = i);
                      _recount();
                    },
                    dense: true,
                  ),
                ),

                const _Header('Location'),
                // commute switch row
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Brand.textDark),
                            children: const [
                              TextSpan(text: 'Buy or rent home by '),
                              TextSpan(
                                text: 'commute time',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Switch(
                        value: _byCommute,
                        activeColor: Brand.green,
                        onChanged: (v) {
                          setState(() => _byCommute = v);
                          _recount();
                        },
                      ),
                    ],
                  ),
                ),

                // search input
                TextField(
                  controller: _searchCtrl,
                  onSubmitted: (q) {
                    if (q.trim().isEmpty) return;
                    setState(() {
                      _selectedLocations.add(_LocationTag(q.trim()));
                      _searchCtrl.clear();
                    });
                    _recount();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for localities, areas or cities',
                    filled: true,
                    fillColor: const Color(0xFFF7FAF9),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Brand.borderLight,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Brand.borderLight,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Brand.green,
                        width: 1.6,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // selected chips
                if (_selectedLocations.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tag in _selectedLocations) ...[
                        InputChip(
                          // circular / pill shape
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: Brand.borderLight,
                            width: 1,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          label: Text(
                            tag.label,
                            style: const TextStyle(color: Brand.textDark),
                          ),
                          deleteIconColor: Brand.textDark,
                          onDeleted: () {
                            setState(() => _selectedLocations.remove(tag));
                            _recount();
                          },
                        ),
                        if (tag.meta != null)
                          Chip(
                            shape: const StadiumBorder(),
                            label: Text(
                              tag.meta!,
                              style: const TextStyle(
                                color: Brand.textDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            backgroundColor: const Color(0xFFEFF7F4),
                            side: const BorderSide(
                              color: Brand.borderLight,
                              width: 1,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                      ],
                    ],
                  ),

                const SizedBox(height: 18),
                const _Header('Completion Status'),
                _ChoicePills(
                  options: const ['All', 'Ready', 'Off-Plan'],
                  index: _completion,
                  onChanged: (i) {
                    setState(() => _completion = i);
                    _recount();
                  },
                ),

                const SizedBox(height: 18),
                const _Header('Property Type'),
                _SegmentedTwo(
                  left: 'Residential',
                  right: 'Commercial',
                  index: _propSegment,
                  onChanged: (i) {
                    setState(() => _propSegment = i);
                    _recount();
                  },
                ),
                const SizedBox(height: 12),

                // grid of types
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.0,
                  children: [
                    _TypeCard(
                      label: 'Apartment',
                      icon: Icons.apartment,
                      selected: _selectedType == 'Apartment',
                      onTap: () {
                        setState(() => _selectedType = 'Apartment');
                        _recount();
                      },
                    ),
                    _TypeCard(
                      label: 'Villa',
                      icon: Icons.holiday_village,
                      selected: _selectedType == 'Villa',
                      onTap: () {
                        setState(() => _selectedType = 'Villa');
                        _recount();
                      },
                    ),
                    _TypeCard(
                      label: 'Townhouse',
                      icon: Icons.house_sharp,
                      selected: _selectedType == 'Townhouse',
                      onTap: () {
                        setState(() => _selectedType = 'Townhouse');
                        _recount();
                      },
                    ),
                    _TypeCard(
                      label: 'Penthouse',
                      icon: Icons.domain,
                      selected: _selectedType == 'Penthouse',
                      onTap: () {
                        setState(() => _selectedType = 'Penthouse');
                        _recount();
                      },
                    ),
                    _TypeCard(
                      label: 'Plot',
                      icon: Icons.crop_square,
                      selected: _selectedType == 'Plot',
                      onTap: () {
                        setState(() => _selectedType = 'Plot');
                        _recount();
                      },
                    ),
                    _TypeCard(
                      label: 'Duplex',
                      icon: Icons.other_houses_outlined,
                      selected: _selectedType == 'Duplex',
                      onTap: () {
                        setState(() => _selectedType = 'Duplex');
                        _recount();
                      },
                    ),
                  ],
                ),
                SizedBox(height: pad.bottom + 24),
              ],
            ),
          ),

          // Bottom bar
          Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + pad.bottom),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: _resetAll,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Brand.textDark,
                    side: const BorderSide(color: Brand.borderLight, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // return selected filters to caller if you want
                      Navigator.pop(context, _collectFilters());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Brand.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                    child: Text('Show $_resultsCount properties'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _collectFilters() {
    return {
      'tab': _topTab == 0 ? 'properties' : 'new_projects',
      'intent': _intent == 0 ? 'buy' : 'rent',
      'byCommute': _byCommute,
      'locations': _selectedLocations.map((e) => e.label).toList(),
      'completion': ['all', 'ready', 'off-plan'][_completion],
      'segment': _propSegment == 0 ? 'residential' : 'commercial',
      'type': _selectedType,
    };
  }
}

/// Helpers & small widgets

class _Header extends StatelessWidget {
  const _Header(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 14, 0, 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Brand.textDark,
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 12), child: child);
  }
}

class _SegmentedTwo extends StatelessWidget {
  const _SegmentedTwo({
    required this.left,
    required this.right,
    required this.index,
    required this.onChanged,
    this.dense = false,
  });

  final String left;
  final String right;
  final int index;
  final ValueChanged<int> onChanged;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final height = dense ? 40.0 : 48.0;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F6F4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Brand.borderLight, width: 1),
      ),
      child: Row(children: [_segBtn(left, 0), _segBtn(right, 1)]),
    );
  }

  Widget _segBtn(String label, int i) {
    final selected = index == i;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => onChanged(i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: selected ? Brand.green : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Brand.textDark,
            ),
          ),
        ),
      ),
    );
  }
}

class _ChoicePills extends StatelessWidget {
  const _ChoicePills({
    required this.options,
    required this.index,
    required this.onChanged,
  });

  final List<String> options;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (int i = 0; i < options.length; i++)
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => onChanged(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: index == i ? const Color(0xFFEFF7F4) : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: index == i ? Brand.green : Brand.borderLight,
                  width: 1,
                ),
              ),
              child: Text(
                options[i],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Brand.textDark,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFFEFF7F4) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? Brand.green : Brand.borderLight,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 34, color: Brand.textDark),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Brand.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationTag {
  _LocationTag(this.label, {this.meta});
  final String label;
  final String? meta;
}
