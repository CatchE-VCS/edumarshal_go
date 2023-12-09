import 'package:edumarshal/controllers/db_controller.dart';
import 'package:edumarshal/screens/home_nav/hidden_drawer.dart';
import 'package:edumarshal/screens/login/login_page.dart';
import 'package:flutter/material.dart';

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
        future: handler.retrieveUser(),
        builder: (BuildContext context, AsyncSnapshot<List<Object?>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return HiddenDrawer(
                accessToken: snapshot.data![0].toString(),
              );
            } else {
              return const Login();
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      routes: {
        '/login': (context) => const Login(),
      },
    );
  }
}
