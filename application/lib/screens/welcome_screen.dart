// lib/screens/welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/tour_bloc.dart';
import '../bloc/tour_event.dart';
import '../bloc/tour_state.dart';
import '../repository/tour_repository.dart';
import '../models/tour.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => TourBloc(
          tourRepository:
              TourRepository(baseUrl: 'http://192.168.0.6:8000/api/v1'),
        )..add(FetchTours()),
        child: TourList(),
      ),
    );
  }
}

class TourList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourBloc, TourState>(
      builder: (context, state) {
        if (state is TourLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TourLoaded) {
          return ListView.builder(
            itemCount: state.tours.length,
            itemBuilder: (context, index) {
              Tour tour = state.tours[index];
              return ListTile(
                title: Text(tour.name),
                subtitle: Text(tour.description),
              );
            },
          );
        } else if (state is TourError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('No tours available.'));
        }
      },
    );
  }
}
