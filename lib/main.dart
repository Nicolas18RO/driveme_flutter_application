import 'package:drive_me_application_v02/Home%20Module/Screen/home_screen.dart';
import 'package:drive_me_application_v02/Login%20Module/View/auth_screen.dart';
import 'package:drive_me_application_v02/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() async {
  await setUp();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

Future<void> setUp() async {
  await dotenv.load(
    fileName: '.env',
  );
  MapboxOptions.setAccessToken(
    dotenv.env['MAPBOX_ACCESS_TOKEN']!,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeScreen() //AuthScreen()
        );
  }
}
