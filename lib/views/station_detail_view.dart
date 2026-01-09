import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_colors.dart';
import '../viewmodels/station_viewmodel.dart';
import '../widgets/station_header.dart';
import '../widgets/last_update_info.dart';
import '../widgets/bikes_section.dart';
import '../widgets/docks_section.dart';

class StationDetailView extends StatelessWidget {
  const StationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text(
          'Detalle de Estación',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border),
        ),
      ),
      body: Consumer<StationViewModel>(
        builder: (context, viewModel, child) {
          final station = viewModel.selectedStation;

          if (station == null) {
            return const Center(child: Text('No hay estación seleccionada'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StationHeader(station: station),
                const SizedBox(height: 16),
                LastUpdateInfo(lastUpdate: station.lastUpdate),
                const SizedBox(height: 24),
                BikesSection(station: station),
                const SizedBox(height: 24),
                DocksSection(station: station),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
