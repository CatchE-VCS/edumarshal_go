// class App extends StatelessWidget {
//   const App({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     DataBaseCon handler = DataBaseCon();
//
//     return MaterialApp(
//       title: 'EduMarshal App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//         fontFamily: GoogleFonts.poppins().fontFamily,
//         primarySwatch: Colors.deepPurple,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: FutureBuilder(
//         future: handler.getUserById(1),
//         builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.hasData) {
//             if (snapshot.data != null) {
//               return HiddenDrawerPage(
//                 accessToken: snapshot.data!.accessToken,
//               );
//             } else {
//               return const Login();
//             }
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return const Login();
//           }
//         },
//       ),
//       routes: {
//         '/login': (context) => const Login(),
//       },
//     );
//   }
// }
