import 'package:edumarshal/controllers/db_controller.dart';
import 'package:edumarshal/screens/home_nav/hidden_drawer.dart';
import 'package:edumarshal/screens/login/login_page.dart';
import 'package:flutter/material.dart';

import 'controllers/model.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DataBaseCon handler = DataBaseCon();

    return MaterialApp(
      title: 'EduMarshal App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: handler.getUserById(1),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return HiddenDrawer(
                accessToken: snapshot.data!.accessToken,
              );
            } else {
              return const Login();
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Login();
          }
        },
      ),
      routes: {
        '/login': (context) => const Login(),
      },
    );
  }
}
