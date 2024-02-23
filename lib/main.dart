import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fridgespy/views/navigation.dart';
import 'config/color_scheme.dart';
import 'config/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FridgeSpy());
}

class FridgeSpy extends StatelessWidget {
  const FridgeSpy({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const Navigation(),
    );
  }
}
