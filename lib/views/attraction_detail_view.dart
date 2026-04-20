import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/touristic_attraction.dart';
import '../services/colombia_service.dart';
import '../themes/app_theme.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

class AttractionDetailView extends StatefulWidget {
  final int attractionId;

  const AttractionDetailView({super.key, required this.attractionId});

  @override
  State<AttractionDetailView> createState() => _AttractionDetailViewState();
}

class _AttractionDetailViewState extends State<AttractionDetailView> {
  late Future<TouristicAttraction> _future;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _future = TouristicAttractionService.getById(widget.attractionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/attractions'),
        ),
      ),
      body: FutureBuilder<TouristicAttraction>(
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

          final a = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                // ── Hero image ──
                if (a.primaryImage != null)
                  SizedBox(
                    width: double.infinity,
                    height: 220,
                    child: Image.network(
                      a.primaryImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFD97706).withValues(alpha: 0.15),
                        child: const Center(
                          child: Icon(Icons.image_not_supported,
                              color: Color(0xFFD97706), size: 48),
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFD97706), Color(0xFFB45309)],
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.place_rounded,
                          color: Colors.white, size: 56),
                    ),
                  ),

                // ── Title & location ──
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        a.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      if (a.cityName != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded,
                                size: 16, color: Color(0xFFD97706)),
                            const SizedBox(width: 4),
                            Text(
                              a.cityName!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                // ── Coordinates ──
                if (a.latitude != null && a.longitude != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.explore_rounded,
                              color: AppTheme.primary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Coordenadas',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Lat: ${a.latitude}  |  Lng: ${a.longitude}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // ── Description ──
                if (a.description != null && a.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.article_rounded,
                                    color: AppTheme.primary, size: 20),
                                SizedBox(width: 8),
                                Text(
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
                              a.description!,
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
