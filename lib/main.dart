import 'package:flutter/material.dart';
import 'package:i_moments/pages/create_event_page.dart';
import 'package:i_moments/pages/dashboard_page.dart';
import 'package:i_moments/pages/login_page.dart';
import 'package:i_moments/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMoments',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/register', // <<< ini WAJIB
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/create-event': (context) => const CreateEventPage(),
      },
    );
  }
}
