import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/president.dart';
import '../services/colombia_service.dart';
import '../themes/app_theme.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

class PresidentListView extends StatefulWidget {
  const PresidentListView({super.key});

  @override
  State<PresidentListView> createState() => _PresidentListViewState();
}

class _PresidentListViewState extends State<PresidentListView> {
  late Future<List<President>> _future;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _future = PresidentService.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presidentes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/'),
        ),
      ),
      body: FutureBuilder<List<President>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(message: 'Cargando presidentes...');
          }
          if (snapshot.hasError) {
            return ErrorDisplay(
              message: snapshot.error.toString(),
              onRetry: () => setState(() => _loadData()),
            );
          }

          final presidents = snapshot.data!;
          // Sort by start date
          presidents.sort((a, b) {
            final aDate = a.startPeriodDate ?? '';
            final bDate = b.startPeriodDate ?? '';
            return aDate.compareTo(bDate);
          });

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: presidents.length,
            itemBuilder: (context, index) {
              final p = presidents[index];
              return Card(
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFF059669),
                    backgroundImage: (p.image != null &&
                            p.image!.isNotEmpty &&
                            p.image != 'null' &&
                            p.image!.startsWith('http'))
                        ? NetworkImage(p.image!)
                        : null,
                    child: (p.image == null ||
                            p.image!.isEmpty ||
                            p.image == 'null' ||
                            !p.image!.startsWith('http'))
                        ? Text(
                            p.name.isNotEmpty ? p.name[0] : '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  title: Text(
                    p.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        p.politicalParty ?? 'Partido desconocido',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      Text(
                        p.periodLabel,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.textSecondary.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded,
                      color: AppTheme.textSecondary),
                  onTap: () => context.go('/presidents/${p.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
