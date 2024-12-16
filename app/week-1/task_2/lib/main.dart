import 'package:flutter/material.dart';
import 'login_page.dart';
import 'welcome_page.dart';
import 'register_page.dart';

void main() {
  runApp(const Task5App());
}

class Task5App extends StatelessWidget {
  const Task5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}



