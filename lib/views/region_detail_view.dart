import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/region.dart';
import '../services/colombia_service.dart';
import '../themes/app_theme.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

class RegionDetailView extends StatefulWidget {
  final int regionId;

  const RegionDetailView({super.key, required this.regionId});

  @override
  State<RegionDetailView> createState() => _RegionDetailViewState();
}

class _RegionDetailViewState extends State<RegionDetailView> {
  late Future<Region> _future;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _future = RegionService.getById(widget.regionId);
  }

  static const _regionColors = {
    1: Color(0xFF0EA5E9), // Caribe
    2: Color(0xFF10B981), // Pacífico
    3: Color(0xFFF59E0B), // Orinoquía
    4: Color(0xFF22C55E), // Amazonía
    5: Color(0xFF8B5CF6), // Andina
    6: Color(0xFFEC4899), // Insular
  };

  static const _regionIcons = {
    1: Icons.waves_rounded,
    2: Icons.water_rounded,
    3: Icons.grass_rounded,
    4: Icons.forest_rounded,
    5: Icons.terrain_rounded,
    6: Icons.sailing_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/regions'),
        ),
      ),
      body: FutureBuilder<Region>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return ErrorDisplay(
              message: snapshot.error.toString(),
              onRetry: () => setState(() => _loadData()),
            );
          }

          final region = snapshot.data!;
          final color =
              _regionColors[region.id] ?? AppTheme.primary;
          final icon =
              _regionIcons[region.id] ?? Icons.terrain_rounded;

          return SingleChildScrollView(
            child: Column(
              children: [
                // ── Header ──
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withValues(alpha: 0.8),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 48, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Región ${region.name}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // ── Description ──
                if (region.description != null &&
                    region.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info_outline_rounded,
                                    color: color, size: 20),
                                const SizedBox(width: 8),
                                const Text(
                                  'Descripción',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              region.description!,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.6,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
