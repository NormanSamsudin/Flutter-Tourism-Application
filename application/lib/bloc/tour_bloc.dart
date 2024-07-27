// lib/bloc/tour_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/tour_repository.dart';
import 'tour_event.dart';
import 'tour_state.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  final TourRepository tourRepository;

  TourBloc({required this.tourRepository}) : super(TourInitial()) {
    on<FetchTours>(_onFetchTours);
  }

  void _onFetchTours(FetchTours event, Emitter<TourState> emit) async {
    emit(TourLoading());
    try {
      final tours = await tourRepository.fetchTours();
      emit(TourLoaded(tours));
    } catch (e) {
      emit(TourError(e.toString()));
    }
  }
}
