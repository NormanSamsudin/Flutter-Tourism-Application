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
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/auth_repository.dart';
import 'repository/tour_repository.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/tour_bloc.dart';
import 'screens/login_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  String baseUrl = await readUrlFromJsonFile();

  final AuthRepository authRepository = AuthRepository(baseUrl: baseUrl);
  final TourRepository tourRepository = TourRepository(baseUrl: baseUrl);

  runApp(MyApp(authRepository: authRepository, tourRepository: tourRepository));
}

Future<String> readUrlFromJsonFile() async {
  try {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/data/config.json');
    String contents = await file.readAsString();
    Map<String, dynamic> json = jsonDecode(contents);
    return json['baseUrl'].trim();
  } catch (e) {
    // Handle error (e.g., file not found, read error, JSON parsing error)
    debugPrint('Error reading URL from JSON file: $e');
    // Return a default URL or handle error appropriately
    return 'http://192.168.0.6:8000/api/v1';
  }
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final TourRepository tourRepository;

  MyApp({required this.authRepository, required this.tourRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider(
          create: (context) => TourBloc(tourRepository: tourRepository),
        ),
      ],
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
