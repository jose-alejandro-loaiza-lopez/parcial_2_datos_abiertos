import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';
import '../widgets/dashboard_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Sliver App Bar with Colombian flag stripe ──
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppTheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: const Text(
                'Colombia Open Data',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient background
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF0D2137),
                          AppTheme.primary,
                        ],
                      ),
                    ),
                  ),
                  // Colombian flag decoration
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(height: 4, color: AppTheme.colYellow),
                        ),
                        Expanded(
                          child: Container(height: 4, color: AppTheme.colBlue),
                        ),
                        Expanded(
                          child: Container(height: 4, color: AppTheme.colRed),
                        ),
                      ],
                    ),
                  ),
                  // Decorative circle
                  Positioned(
                    top: -30,
                    right: -30,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 40,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.04),
                      ),
                    ),
                  ),
                  // Centered icon
                  const Center(
                    child: Icon(
                      Icons.public_rounded,
                      size: 64,
                      color: Colors.white24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Section title ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 4),
              child: Text(
                'Explora los datos',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                'Selecciona una categoría para consultar la API Colombia',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ),

          // ── Grid of cards ──
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildListDelegate([
                DashboardCard(
                  icon: Icons.map_rounded,
                  title: 'Departamentos',
                  subtitle: 'Conoce los 32 departamentos de Colombia',
                  gradientStart: const Color(0xFF2563EB),
                  gradientEnd: const Color(0xFF1D4ED8),
                  onTap: () => context.go('/departments'),
                ),
                DashboardCard(
                  icon: Icons.person_rounded,
                  title: 'Presidentes',
                  subtitle: 'Historia presidencial de Colombia',
                  gradientStart: const Color(0xFF059669),
                  gradientEnd: const Color(0xFF047857),
                  onTap: () => context.go('/presidents'),
                ),
                DashboardCard(
                  icon: Icons.place_rounded,
                  title: 'Atracciones',
                  subtitle: 'Lugares turísticos imperdibles',
                  gradientStart: const Color(0xFFD97706),
                  gradientEnd: const Color(0xFFB45309),
                  onTap: () => context.go('/attractions'),
                ),
                DashboardCard(
                  icon: Icons.terrain_rounded,
                  title: 'Regiones',
                  subtitle: 'Las 6 regiones naturales de Colombia',
                  gradientStart: const Color(0xFF7C3AED),
                  gradientEnd: const Color(0xFF6D28D9),
                  onTap: () => context.go('/regions'),
                ),
              ]),
            ),
          ),

          // Bottom spacing
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
