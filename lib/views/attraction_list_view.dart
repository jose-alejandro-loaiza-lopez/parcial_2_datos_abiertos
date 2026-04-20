import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/touristic_attraction.dart';
import '../services/colombia_service.dart';
import '../themes/app_theme.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

class AttractionListView extends StatefulWidget {
  const AttractionListView({super.key});

  @override
  State<AttractionListView> createState() => _AttractionListViewState();
}

class _AttractionListViewState extends State<AttractionListView> {
  late Future<List<TouristicAttraction>> _future;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _future = TouristicAttractionService.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atracciones Turísticas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/'),
        ),
      ),
      body: FutureBuilder<List<TouristicAttraction>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(message: 'Cargando atracciones...');
          }
          if (snapshot.hasError) {
            return ErrorDisplay(
              message: snapshot.error.toString(),
              onRetry: () => setState(() => _loadData()),
            );
          }

          final attractions = snapshot.data!;
          attractions.sort((a, b) => a.name.compareTo(b.name));

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: attractions.length,
            itemBuilder: (context, index) {
              final a = attractions[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => context.go('/attractions/${a.id}'),
                  child: Row(
                    children: [
                      // Thumbnail
                      SizedBox(
                        width: 100,
                        height: 80,
                        child: a.primaryImage != null
                            ? Image.network(
                                a.primaryImage!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: const Color(0xFFD97706)
                                      .withValues(alpha: 0.15),
                                  child: const Icon(Icons.image_not_supported,
                                      color: Color(0xFFD97706)),
                                ),
                              )
                            : Container(
                                color: const Color(0xFFD97706)
                                    .withValues(alpha: 0.15),
                                child: const Icon(Icons.place_rounded,
                                    color: Color(0xFFD97706), size: 32),
                              ),
                      ),
                      // Info
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                a.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              if (a.cityName != null)
                                Text(
                                  a.cityName!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.chevron_right_rounded,
                            color: AppTheme.textSecondary),
                      ),
                    ],
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
