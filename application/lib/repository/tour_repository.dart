// lib/repository/tour_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tour.dart';

class TourRepository {
  final String baseUrl;

  TourRepository({required this.baseUrl});

  Future<List<Tour>> fetchTours() async {
    final response = await http.get(Uri.parse('$baseUrl/tours'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Tour> tours = body.map((dynamic item) => Tour.fromJson(item)).toList();
      return tours;
    } else {
      throw Exception('Failed to load tours');
    }
  }
}
