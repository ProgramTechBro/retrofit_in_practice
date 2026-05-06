import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ProductSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: GoogleFonts.dmSans(
            fontSize: 15,
            color: const Color(0xFF1A1A2E),
          ),
          decoration: InputDecoration(
            hintText: 'Search products or categories...',
            hintStyle: GoogleFonts.dmSans(
              fontSize: 15,
              color: const Color(0xFFABABAB),
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFFABABAB),
              size: 22,
            ),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (_, value, __) {
                if (value.text.isEmpty) return const SizedBox.shrink();
                return GestureDetector(
                  onTap: () {
                    controller.clear();
                    onChanged('');
                  },
                  child: const Icon(
                    Icons.cancel_rounded,
                    color: Color(0xFFABABAB),
                    size: 20,
                  ),
                );
              },
            ),
            border: InputBorder.none,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ),
    );
  }
}