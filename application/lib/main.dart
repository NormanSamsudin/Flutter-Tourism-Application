// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'repository/auth_repository.dart';
// import 'bloc/auth_bloc.dart';
// import 'screens/login_screen.dart';

// void main() {
//   final AuthRepository authRepository =
//       AuthRepository(baseUrl: 'http://192.168.0.6:8000/api/v1/users');

//   runApp(MyApp(authRepository: authRepository));
// }

// class MyApp extends StatelessWidget {
//   final AuthRepository authRepository;

//   MyApp({required this.authRepository});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Auth',
//       home: BlocProvider(
//         create: (context) => AuthBloc(authRepository: authRepository),
//         child: LoginScreen(),
//       ),
//     );
//   }
// }

// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/auth_repository.dart';
import 'bloc/auth_bloc.dart';
import 'screens/login_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  final AuthRepository authRepository = AuthRepository(baseUrl: 'http://192.168.0.6:8000/api/v1/users');

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  MyApp({required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: authRepository),
      child: MaterialApp(
        title: 'Flutter Auth',
        home: LoginScreen(),
        routes: {
          '/welcome': (context) => WelcomeScreen(),
        },
      ),
    );
  }
}
