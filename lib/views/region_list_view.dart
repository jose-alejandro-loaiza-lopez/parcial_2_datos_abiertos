import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/region.dart';
import '../services/colombia_service.dart';
import '../themes/app_theme.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

class RegionListView extends StatefulWidget {
  const RegionListView({super.key});

  @override
  State<RegionListView> createState() => _RegionListViewState();
}

class _RegionListViewState extends State<RegionListView> {
  late Future<List<Region>> _future;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _future = RegionService.getAll();
  }

  // Colors assigned to each region for visual distinction
  static const _regionColors = [
    Color(0xFF0EA5E9), // Caribe
    Color(0xFF10B981), // Pacífico
    Color(0xFFF59E0B), // Orinoquía
    Color(0xFF22C55E), // Amazonía
    Color(0xFF8B5CF6), // Andina
    Color(0xFFEC4899), // Insular
  ];

  static const _regionIcons = [
    Icons.waves_rounded,
    Icons.water_rounded,
    Icons.grass_rounded,
    Icons.forest_rounded,
    Icons.terrain_rounded,
    Icons.sailing_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regiones'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/'),
        ),
      ),
      body: FutureBuilder<List<Region>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(message: 'Cargando regiones...');
          }
          if (snapshot.hasError) {
            return ErrorDisplay(
              message: snapshot.error.toString(),
              onRetry: () => setState(() => _loadData()),
            );
          }

          final regions = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: regions.length,
            itemBuilder: (context, index) {
              final region = regions[index];
              final color =
                  _regionColors[index % _regionColors.length];
              final icon = _regionIcons[index % _regionIcons.length];

              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => context.go('/regions/${region.id}'),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(icon, color: color, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                region.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                region.description ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppTheme.textSecondary),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
