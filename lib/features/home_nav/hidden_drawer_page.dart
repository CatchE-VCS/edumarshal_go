import 'package:auto_route/auto_route.dart';
import 'package:edumarshal/ext_package/hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:edumarshal/features/dashboard/dashboard.dart';
import 'package:edumarshal/features/events/events_page.dart';
import 'package:edumarshal/features/payment/payment_history_page.dart';
import 'package:edumarshal/features/profile/view/profile_page.dart';
import 'package:edumarshal/features/time_table/time_table_page.dart';
import 'package:edumarshal/features/widgets/dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../auth/auth.dart';
import '../barcode/barcode.dart';

@RoutePage(
  deferredLoading: true,
)
class HiddenDrawerPage extends StatefulWidget {
  const HiddenDrawerPage({super.key, required this.accessToken});

  final String accessToken;

  @override
  State<HiddenDrawerPage> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawerPage> {
  List<ScreenHiddenDrawer> _pages = [];

  late String email;

  @override
  void initState() {
    super.initState();

    // Map<String, dynamic>? jwtDecodedToken;
    if (kDebugMode) {
      print("Access Token: ");
      print(widget.accessToken);
    }
    try {
      // jwtDecodedToken = JwtDecoder.decode(widget.accessToken!);
      // if (kDebugMode) {
      // print("---------------------");
      //
      // print(jwtDecodedToken);
      // print("---------------------");
      // }
    } catch (e) {
      if (kDebugMode) {
        print('Error decoding token: $e');
      }
    }

    // Use default value if email is null
    // email = jwtDecodedToken?['email'] ?? 'DefaultEmail';
    email = 'DefaultEmail';

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Dashboard',
          baseStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          selectedStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          colorLineSelected: const Color.fromARGB(255, 251, 162, 45),
        ),
        const DashboardPage(),
      ),

      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Profile',
            baseStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            selectedStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            colorLineSelected: const Color.fromARGB(255, 251, 162, 45)),
        const ProfilePage(),
      ),

      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Events',
            baseStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            selectedStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            colorLineSelected: const Color.fromARGB(255, 251, 162, 45)),
        const EventsPage(),
      ),

      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'E-Identity',
            baseStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            selectedStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            colorLineSelected: const Color.fromARGB(255, 251, 162, 45)),
        const BarGen(),
      ),

      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Calender',
            baseStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            selectedStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            colorLineSelected: const Color.fromARGB(255, 251, 162, 45)),
        const TimeTablePage(),
      ),

      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Payment',
            baseStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            selectedStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            colorLineSelected: const Color.fromARGB(255, 251, 162, 45)),
        const PaymentHistoryPage(),
      ),

      //  ScreenHiddenDrawer(
      //   ItemHiddenMenu(
      //   name: 'Test',
      //   baseStyle: const TextStyle(
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.white,
      //   ),
      //   selectedStyle: const TextStyle(
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.white,

      //   ),
      //    colorLineSelected: const Color.fromARGB(255, 251, 162, 45)
      //   ),

      // ),

      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'SignOut',
          baseStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          selectedStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          onTap: () {
            DBRepository handler = DBRepository();
            handler
                .deleteUser(1)
                .then((_) => context.router.replaceNamed('/login'));
          },
          colorLineSelected: const Color.fromARGB(255, 251, 162, 45),
        ),
        Container(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Dialogs().showExitConfirmationDialog(context);
      },
      child: HiddenDrawerMenu(
        backgroundColorAppBar: const Color(0xFF1E1E1E),
        disableAppBarDefault: false,
        actionsAppBar: const <Widget>[],
        backgroundColorMenu: const Color(0xFF1E1E1E),
        screens: _pages,
        initPositionSelected: 0,
        slidePercent: 50,
        leadingAppBar: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        contentCornerRadius: 25,
        boxShadow: const [],

        // verticalScalePercent: 80.0,
        //    contentCornerRadius: 10.0,
        //  elevationAppBar: 100.0
      ),
    );
  }
}
