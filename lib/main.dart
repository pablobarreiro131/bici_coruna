import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/app_colors.dart';
import 'viewmodels/station_viewmodel.dart';
import 'views/station_list_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StationViewModel(),
      child: MaterialApp(
        title: 'BiciCoruña',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.accent,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.backgroundPrimary,
          cardTheme: CardThemeData(
            elevation: 0,
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColors.border, width: 1),
            ),
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.textPrimary,
          ),
          textTheme: TextTheme(
            bodyLarge: TextStyle(
              color: AppColors.textPrimary,
              letterSpacing: 0.2,
            ),
            bodyMedium: TextStyle(
              color: AppColors.textSecondary,
              letterSpacing: 0.2,
            ),
          ),
        ),
        home: const StationListView(),
      ),
    );
  }
}
