// import 'package:auto_route/auto_route.dart';
// import 'package:edumarshal/core/router/router.gr.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import '../../auth/auth.dart';

// @RoutePage(
//   deferredLoading: true,
// )
// class SplashPage extends StatelessWidget {
//   const SplashPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     DBRepository handler = DBRepository();
//     handler
//         .getUserById(1)
//         .then((value) => value != null
//             ? context.router
//                 .replace(HiddenDrawerRoute(accessToken: value.accessToken))
//             : context.router.replaceNamed('/login'))
//         .catchError((e) {
//       if (kDebugMode) {
//         print(e);
//       }

//       context.router.replaceNamed('/login');
//       return null;
//     });
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }



// import 'package:auto_route/auto_route.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:edumarshal/core/router/router.gr.dart';
// import 'package:flutter/material.dart';

// import '../../auth/auth.dart';

// @RoutePage(
//   deferredLoading: true,
// )
// class SplashPage extends StatelessWidget {
//   const SplashPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
      
//       splash: 'assets/images/B6F8D318-51DD-43B4-8A96-0FAD923E6033.jpeg',
//       nextScreen: FutureBuilder(
//         future: DBRepository().getUserById(1),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               final user = snapshot.data as User;
//               context.router.replace(HiddenDrawerRoute(accessToken: user.accessToken));
//             } else {
//               // context.router.replace(LoginRoute()); // Replace with your login route
//               context.router.replaceNamed('/login');

//             }
//           }
//           // Placeholder loading screen while checking user authentication
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         },
//       ),
//       splashTransition: SplashTransition.rotationTransition,
//       // pageTransitionType: PageTransitionType.scale,
//     );
//   }
// }




import 'package:auto_route/auto_route.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:edumarshal/core/router/router.gr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../auth/auth.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    DBRepository handler = DBRepository();
    handler.getUserById(1).then((value) {
      Future.delayed(const Duration(seconds: 2), () {
        value != null
            ? context.router.replace(
                HiddenDrawerRoute(accessToken: value.accessToken),
              )
            : context.router.replaceNamed('/login');
      });
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }


      context.router.replaceNamed('/login');
      return null;
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(
          'assets/images/Aeronex.svg',
          width: 200,
          height: 200,
        ),
      ),
      splashTransition: SplashTransition.rotationTransition,
      // pageTransitionType: PageTransitionType.scale,
    );
  }
}
