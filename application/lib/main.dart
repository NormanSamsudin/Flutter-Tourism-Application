// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/auth_repository.dart';
import 'bloc/auth_bloc.dart';
import 'screens/login_screen.dart';

void main() {
  final AuthRepository authRepository =
      AuthRepository(baseUrl: 'https://your-backend-url.com');

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  MyApp({required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth',
      home: BlocProvider(
        create: (context) => AuthBloc(authRepository: authRepository),
        child: LoginScreen(),
      ),
    );
  }
}
