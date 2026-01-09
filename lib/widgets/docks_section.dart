import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/station.dart';
import 'dock_card.dart';

class DocksSection extends StatelessWidget {
  final Station station;

  const DocksSection({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'PUESTOS / ANCLAJES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textTertiary,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DockCard(
                  title: 'Puestos Totales',
                  count: station.capacity,
                  icon: Icons.grid_view,
                  color: AppColors.totalDocks,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DockCard(
                  title: 'Puestos Libres',
                  count: station.availableDocks,
                  icon: Icons.check_circle,
                  color: AppColors.availableDocks,
                ),
              ),
            ],
          ),
          if (station.disabledDocks > 0) ...[
            const SizedBox(height: 12),
            DockCard(
              title: 'Puestos Inhabilitados',
              count: station.disabledDocks,
              icon: Icons.block,
              color: AppColors.disabledDocks,
            ),
          ],
        ],
      ),
    );
  }
}
