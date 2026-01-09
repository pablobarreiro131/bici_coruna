import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/station.dart';

class TotalBikesCard extends StatelessWidget {
  final Station station;

  const TotalBikesCard({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final totalAvailable = station.availableBikes;
    final totalDisabled = station.disabledBikes;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1.5),
        boxShadow: AppColors.createMinimalShadow(),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatColumn(
              label: 'DISPONIBLES',
              value: '$totalAvailable',
              color: AppColors.success,
            ),
          ),
          if (totalDisabled > 0) ...[
            Container(width: 1, height: 50, color: AppColors.divider),
            Expanded(
              child: _buildStatColumn(
                label: 'INHABILITADAS',
                value: '$totalDisabled',
                color: AppColors.error,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatColumn({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            gradient: AppColors.createMinimalGradient(color),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
