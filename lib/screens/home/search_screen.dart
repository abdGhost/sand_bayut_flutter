import 'package:flutter/material.dart';
import '../../theme/brand.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    this.initialQuery = '',
    this.intent,
    this.topTab,
  });

  final String initialQuery;
  final String? intent; // e.g., Buy / Rent
  final int? topTab; // e.g., Properties / New Projects / Transactions

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialQuery,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _performSearch(String q) {
    if (q.trim().isEmpty) return;
    // TODO: call your API / navigate to results page
    // For now just close and pass back the query if you like:
    Navigator.of(context).pop(); // or push to a results screen
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Custom appbar with field
            Container(
              padding: EdgeInsets.fromLTRB(12, topPad + 8, 12, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: Brand.textDark,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      onSubmitted: _performSearch,
                      decoration: InputDecoration(
                        hintText: 'Search for a locality, area or city',
                        filled: true,
                        fillColor: const Color(0xFFF7FAF9),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Brand.borderLight,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Brand.borderLight,
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
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Brand.darkTeal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _performSearch(_controller.text),
                    child: const Icon(Icons.search_rounded),
                  ),
                ],
              ),
            ),

            // Body: suggestions / history / results placeholder
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  if (widget.intent != null || widget.topTab != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Searching in: '
                        '${widget.topTab == 0
                            ? "Properties"
                            : widget.topTab == 1
                            ? "New Projects"
                            : widget.topTab == 2
                            ? "Transactions"
                            : "All"}'
                        '${widget.intent != null ? " • ${widget.intent}" : ""}',
                        style: TextStyle(color: Brand.textMute, fontSize: 13),
                      ),
                    ),

                  const Text(
                    'Recent searches',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _chip('Marina'),
                      _chip('Downtown'),
                      _chip('JVC 2BR'),
                      _chip('Off-plan near metro'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  const Text(
                    'Popular areas',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  ...[
                    'Dubai Marina',
                    'Downtown Dubai',
                    'Business Bay',
                    'Jumeirah Village Circle',
                  ].map(
                    (s) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(s),
                      trailing: const Icon(Icons.north_east_rounded, size: 18),
                      onTap: () => _performSearch(s),
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

  Widget _chip(String label) {
    return InkWell(
      onTap: () => _performSearch(label),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFFF7FAF9),
          border: Border.all(color: Brand.borderLight),
        ),
        child: Text(label),
      ),
    );
  }
}
