class Region {
  final int id;
  final String name;
  final String? description;

  Region({
    required this.id,
    required this.name,
    this.description,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Sin nombre',
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
