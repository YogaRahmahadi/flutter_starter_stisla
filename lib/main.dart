import 'package:flutter/material.dart';
import 'package:flutter_starter_stisla/screens/home.dart';
import 'package:flutter_starter_stisla/screens/login_screen.dart';
import 'package:flutter_starter_stisla/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'laravel9-starter-stisla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
