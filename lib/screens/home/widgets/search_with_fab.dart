import 'package:flutter/material.dart';
import '../../../theme/brand.dart';

class SearchWithFab extends StatelessWidget {
  const SearchWithFab({
    super.key,
    this.controller,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
    this.onFabTap,
    this.readOnly = true, // ⬅️ default true so we route to SearchScreen
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap; // ⬅️ new
  final VoidCallback? onFabTap; // ⬅️ new
  final bool readOnly; // ⬅️ new

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF111827);
    const hintColor = Color(0xFF6B7280);

    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Brand.green,
          selectionColor: Brand.green.withOpacity(0.18),
          selectionHandleColor: Brand.green,
        ),
      ),
      child: Stack(
        children: [
          TextField(
            controller: controller,
            onSubmitted: onSubmitted,
            onChanged: onChanged,
            onTap: onTap, // ⬅️ triggers navigation
            readOnly: readOnly, // ⬅️ blocks keyboard until new screen
            style: const TextStyle(color: textColor, fontSize: 16, height: 1.2),
            cursorColor: Brand.green,
            cursorWidth: 2,
            cursorRadius: const Radius.circular(2),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search for a locality, area or city',
              hintStyle: const TextStyle(color: hintColor),
              filled: true,
              fillColor: const Color(0xFFF7FAF9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Brand.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Brand.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Brand.green, width: 1.6),
              ),
              contentPadding: const EdgeInsets.fromLTRB(14, 16, 56, 16),
            ),
          ),

          // Search FAB on the right
          Positioned(
            right: 8,
            top: 6,
            bottom: 6,
            child: Material(
              color: Brand.darkTeal,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onFabTap ?? onTap, // ⬅️ also open search
                child: const SizedBox(
                  width: 44,
                  height: 44,
                  child: Icon(Icons.search_rounded, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
