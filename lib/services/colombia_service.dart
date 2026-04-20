import '../models/department.dart';
import '../models/president.dart';
import '../models/touristic_attraction.dart';
import '../models/region.dart';
import 'api_service.dart';

class DepartmentService {
  static Future<List<Department>> getAll() async {
    final data = await ApiService.fetchList('Department');
    return data
        .map((e) => Department.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<Department> getById(int id) async {
    final data = await ApiService.fetchOne('Department', id);
    return Department.fromJson(data);
  }
}

class PresidentService {
  static Future<List<President>> getAll() async {
    final data = await ApiService.fetchList('President');
    return data
        .map((e) => President.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<President> getById(int id) async {
    final data = await ApiService.fetchOne('President', id);
    return President.fromJson(data);
  }
}

class TouristicAttractionService {
  static Future<List<TouristicAttraction>> getAll() async {
    final data = await ApiService.fetchList('TouristicAttraction');
    return data
        .map((e) => TouristicAttraction.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<TouristicAttraction> getById(int id) async {
    final data = await ApiService.fetchOne('TouristicAttraction', id);
    return TouristicAttraction.fromJson(data);
  }
}

class RegionService {
  static Future<List<Region>> getAll() async {
    final data = await ApiService.fetchList('Region');
    return data
        .map((e) => Region.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<Region> getById(int id) async {
    final data = await ApiService.fetchOne('Region', id);
    return Region.fromJson(data);
  }
}
