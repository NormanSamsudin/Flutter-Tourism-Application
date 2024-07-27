// lib/bloc/tour_state.dart
import '../models/tour.dart';

abstract class TourState {}

class TourInitial extends TourState {}

class TourLoading extends TourState {}

class TourLoaded extends TourState {
  final List<Tour> tours;

  TourLoaded(this.tours);
}

class TourError extends TourState {
  final String message;

  TourError(this.message);
}
