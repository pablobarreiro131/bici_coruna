import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/station.dart';
import 'bike_card.dart';
import 'total_bikes_card.dart';

class BikesSection extends StatelessWidget {
  final Station station;

  const BikesSection({super.key, required this.station});

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
              'BICICLETAS DISPONIBLES',
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
                child: BikeCard(
                  title: 'Mecánicas',
                  count: station.mechanicalBikes,
                  icon: Icons.pedal_bike,
                  color: AppColors.mechanicalBike,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: BikeCard(
                  title: 'Eléctricas',
                  count: station.electricBikes,
                  icon: Icons.electric_bike,
                  color: AppColors.electricBike,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TotalBikesCard(station: station),
        ],
      ),
    );
  }
}
