import 'package:edumarshal/screens/home.dart';
import 'package:edumarshal/screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edumarshal App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Login(),
      routes: {
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
      },
    );
  }
}
