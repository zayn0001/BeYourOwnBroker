// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:micetalks/services/firebase_options.dart';
import 'package:micetalks/homepage.dart';
import 'package:provider/provider.dart';
import 'provider/data.dart';
import "package:micetalks/provider/constants.dart" as constants;
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AllCards(), // Provide Data
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: constants.title,
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(9, 10, 108, 54)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
