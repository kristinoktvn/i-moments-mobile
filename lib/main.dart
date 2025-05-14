import 'package:flutter/material.dart';
import 'package:i_moments/pages/create_event_page.dart';
import 'package:i_moments/pages/dashboard_page.dart';
import 'package:i_moments/pages/login_page.dart';
import 'package:i_moments/pages/profile_page.dart';
import 'package:i_moments/pages/undangan_page.dart';
import 'package:i_moments/pages/register_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'IMoments',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       initialRoute: '/register', // <<< ini WAJIB
//       routes: {
//         '/dashboard': (context) => const DashboardPage(),
//         '/login': (context) => const LoginPage(),
//         '/register': (context) => const RegisterPage(),
//         '/create-event': (context) => const CreateEventPage(),
//       },
//     );
//   }
// }


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const DashboardPage(),
    const UndanganPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Undangan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
