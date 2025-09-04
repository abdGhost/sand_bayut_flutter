import 'package:flutter/material.dart';
import '../../../theme/brand.dart';

class SearchWithFab extends StatelessWidget {
  const SearchWithFab({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search for a locality, area or city',
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 16,
            ),
          ),
        ),
        Positioned(
          right: 8,
          top: 6,
          bottom: 6,
          child: Material(
            color: Brand.darkTeal,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.search_rounded, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
