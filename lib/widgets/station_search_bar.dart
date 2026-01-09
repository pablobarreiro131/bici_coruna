import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class StationSearchBar extends StatelessWidget {
  final Function(String) onSearchChanged;

  const StationSearchBar({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar estación...',
          hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 15),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.textSecondary,
            size: 22,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.border, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.border, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.accent, width: 1.5),
          ),
          filled: true,
          fillColor: AppColors.searchBarBackground,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        style: TextStyle(color: AppColors.textPrimary, fontSize: 15),
        onChanged: onSearchChanged,
      ),
    );
  }
}
