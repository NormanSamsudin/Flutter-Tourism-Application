// lib/models/tour.dart
class Tour {
  final int id;
  final String name;
  final String description;

  Tour({required this.id, required this.name, required this.description});

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
