import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_colors.dart';
import '../viewmodels/station_viewmodel.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_view.dart';
import '../widgets/station_search_bar.dart';
import '../widgets/station_list_item.dart';
import 'station_detail_view.dart';

class StationListView extends StatefulWidget {
  const StationListView({super.key});

  @override
  State<StationListView> createState() => _StationListViewState();
}

class _StationListViewState extends State<StationListView> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StationViewModel>().loadStations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text(
          'BiciCoruña',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border),
        ),
      ),
      body: Consumer<StationViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == StationViewState.loading) {
            return const LoadingIndicator(message: 'Cargando estaciones...');
          }

          if (viewModel.state == StationViewState.error) {
            return ErrorView(
              message: viewModel.errorMessage,
              onRetry: () => viewModel.loadStations(),
            );
          }

          final stations = viewModel.stations.where((station) {
            return station.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
          }).toList();

          return Column(
            children: [
              StationSearchBar(
                onSearchChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => viewModel.refreshStations(),
                  child: ListView.builder(
                    itemCount: stations.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final station = stations[index];
                      return StationListItem(
                        station: station,
                        onTap: () {
                          viewModel.selectStation(station);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StationDetailView(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
