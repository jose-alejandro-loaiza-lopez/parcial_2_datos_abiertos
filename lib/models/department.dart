class CityCapital {
  final int id;
  final String name;
  final String? description;
  final int? surface;
  final int? population;
  final String? postalCode;

  CityCapital({
    required this.id,
    required this.name,
    this.description,
    this.surface,
    this.population,
    this.postalCode,
  });

  factory CityCapital.fromJson(Map<String, dynamic> json) {
    return CityCapital(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Sin nombre',
      description: json['description'] as String?,
      surface: json['surface'] as int?,
      population: json['population'] as int?,
      postalCode: json['postalCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'surface': surface,
      'population': population,
      'postalCode': postalCode,
    };
  }
}

class Department {
  final int id;
  final String name;
  final String? description;
  final int? municipalities;
  final int? surface;
  final int? population;
  final String? phonePrefix;
  final int? regionId;
  final CityCapital? cityCapital;

  Department({
    required this.id,
    required this.name,
    this.description,
    this.municipalities,
    this.surface,
    this.population,
    this.phonePrefix,
    this.regionId,
    this.cityCapital,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Sin nombre',
      description: json['description'] as String?,
      municipalities: json['municipalities'] as int?,
      surface: json['surface'] as int?,
      population: json['population'] as int?,
      phonePrefix: json['phonePrefix'] as String?,
      regionId: json['regionId'] as int?,
      cityCapital: json['cityCapital'] != null
          ? CityCapital.fromJson(json['cityCapital'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'municipalities': municipalities,
      'surface': surface,
      'population': population,
      'phonePrefix': phonePrefix,
      'regionId': regionId,
      'cityCapital': cityCapital?.toJson(),
    };
  }
}
