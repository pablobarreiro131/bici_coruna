import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/station.dart';

class StationHeader extends StatelessWidget {
  final Station station;

  const StationHeader({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppColors.createMinimalGradient(AppColors.accent),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.pedal_bike, color: AppColors.accent, size: 28),
          ),
          const SizedBox(height: 20),
          Text(
            station.name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.textTertiary,
                size: 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  station.address,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
