class TouristicAttraction {
  final int id;
  final String name;
  final String? description;
  final List<String> images;
  final String? latitude;
  final String? longitude;
  final int? cityId;
  final String? cityName;

  TouristicAttraction({
    required this.id,
    required this.name,
    this.description,
    this.images = const [],
    this.latitude,
    this.longitude,
    this.cityId,
    this.cityName,
  });

  /// Returns the first valid image URL, or null.
  String? get primaryImage {
    for (final img in images) {
      if (img.startsWith('http')) return img;
    }
    return null;
  }

  factory TouristicAttraction.fromJson(Map<String, dynamic> json) {
    final rawImages = json['images'] as List<dynamic>? ?? [];
    final imageList = rawImages
        .whereType<String>()
        .toList();

    String? cityName;
    if (json['city'] != null && json['city'] is Map) {
      cityName = (json['city'] as Map<String, dynamic>)['name'] as String?;
    }

    return TouristicAttraction(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Sin nombre',
      description: json['description'] as String?,
      images: imageList,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      cityId: json['cityId'] as int?,
      cityName: cityName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'latitude': latitude,
      'longitude': longitude,
      'cityId': cityId,
    };
  }
}
