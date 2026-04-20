import 'package:go_router/go_router.dart';
import '../views/dashboard_view.dart';
import '../views/department_list_view.dart';
import '../views/department_detail_view.dart';
import '../views/president_list_view.dart';
import '../views/president_detail_view.dart';
import '../views/attraction_list_view.dart';
import '../views/attraction_detail_view.dart';
import '../views/region_list_view.dart';
import '../views/region_detail_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // RUTA RAÍZ: Dashboard
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardView(),
      routes: [
        // Departments
        GoRoute(
          path: 'departments',
          name: 'departments',
          builder: (context, state) => const DepartmentListView(),
          routes: [
            GoRoute(
              path: ':id',
              name: 'department-detail',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return DepartmentDetailView(departmentId: id);
              },
            ),
          ],
        ),

        // Presidents
        GoRoute(
          path: 'presidents',
          name: 'presidents',
          builder: (context, state) => const PresidentListView(),
          routes: [
            GoRoute(
              path: ':id',
              name: 'president-detail',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return PresidentDetailView(presidentId: id);
              },
            ),
          ],
        ),

        // Touristic Attractions
        GoRoute(
          path: 'attractions',
          name: 'attractions',
          builder: (context, state) => const AttractionListView(),
          routes: [
            GoRoute(
              path: ':id',
              name: 'attraction-detail',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return AttractionDetailView(attractionId: id);
              },
            ),
          ],
        ),

        // Regions
        GoRoute(
          path: 'regions',
          name: 'regions',
          builder: (context, state) => const RegionListView(),
          routes: [
            GoRoute(
              path: ':id',
              name: 'region-detail',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return RegionDetailView(regionId: id);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
