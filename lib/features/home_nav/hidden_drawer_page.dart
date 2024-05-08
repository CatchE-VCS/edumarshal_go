import 'package:auto_route/auto_route.dart';
import 'package:edumarshal/ext_package/hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:edumarshal/features/assignment/view/assignment_page.dart';
import 'package:edumarshal/features/dashboard/dashboard.dart';
import 'package:edumarshal/features/home_nav/repository/nav_repository.dart';
import 'package:edumarshal/features/profile/view/profile_page.dart';
import 'package:edumarshal/features/time_table/time_table_page.dart';
import 'package:edumarshal/features/widgets/dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/theme/theme_controller.dart';
import '../auth/auth.dart';
import '../barcode/barcode.dart';
import '../profile/controller/profile_state_pod.dart';

@RoutePage(
  deferredLoading: true,
)
class HiddenDrawerPage extends ConsumerStatefulWidget {
  const HiddenDrawerPage({super.key, required this.accessToken});

  final String accessToken;

  @override
  ConsumerState<HiddenDrawerPage> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends ConsumerState<HiddenDrawerPage> {
  List<ScreenHiddenDrawer> _pages = [];

  // late String email;

  // late bool _flexibleUpdateAvailable;
  void checkAppUpdate() async {
    try {
      var x = await InAppUpdate.checkForUpdate();
      if (x.updateAvailability == UpdateAvailability.updateAvailable) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (kDebugMode) {
          print('Update available');
        }
        if (prefs.getBool('updateAvailable') == true) {
          await prefs.setBool('updateAvailable', false);
          if (!mounted) return;
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'UPDATE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                  ),
                ),
                content: Text(
                  'A new update is available. Please update the app to continue using it.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var navigator = Navigator.of(context);
                      await InAppUpdate.performImmediateUpdate();
                      navigator.pop();
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          return;
        } else {
          await prefs.setBool('updateAvailable', true);
          try {
            await InAppUpdate.startFlexibleUpdate();
          } catch (e) {
            if (kDebugMode) {
              print('Error starting flexible update: $e');
            }
            return;
          }
          try {
            await InAppUpdate.completeFlexibleUpdate();
          } catch (e) {
            if (kDebugMode) {
              print('Error completing flexible update: $e');
            }
            return;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking for update: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkAppUpdate();

    if (kDebugMode) {
      print("Access Token: ");
      print(widget.accessToken);
    }

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Dashboard',
          baseStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
          selectedStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
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
            // color: Colors.white,
          ),
          selectedStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
          colorLineSelected: const Color.fromARGB(255, 251, 162, 45),
        ),
        const ProfilePage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Assignment',
            baseStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              // color: Colors.white,
            ),
            selectedStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              // color: Colors.white,
            ),
            colorLineSelected: const Color.fromARGB(255, 251, 162, 45)),
        const AssignmentPage(),
      ),

      // ScreenHiddenDrawer(
      //   ItemHiddenMenu(
      //       name: 'Events',
      //       baseStyle: const TextStyle(
      //         fontSize: 20,
      //         fontWeight: FontWeight.bold,
      //         // color: Colors.white,
      //       ),
      //       selectedStyle: const TextStyle(
      //         fontSize: 20,
      //         fontWeight: FontWeight.bold,
      //         // color: Colors.white,
      //       ),
      //       colorLineSelected: const Color.fromARGB(255, 251, 162, 45)),
      //   const EventsPage(),
      // ),

      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'E-Identity',
            baseStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              // color: Colors.white,
            ),
            selectedStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              // color: Colors.white,
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
            // color: Colors.white,
          ),
          selectedStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
          // colorLineSelected: const Color.fromARGB(255, 251, 162, 45),
        ),
        const TimeTablePage(),
      ),

      // ScreenHiddenDrawer(
      //   ItemHiddenMenu(
      //       name: 'Payment',
      //       baseStyle: const TextStyle(
      //         fontSize: 20,
      //         fontWeight: FontWeight.bold,
      //         // color: Colors.white,
      //       ),
      //       selectedStyle: const TextStyle(
      //         fontSize: 20,
      //         fontWeight: FontWeight.bold,
      //         // color: Colors.white,
      //       ),
      //       colorLineSelected: const Color.fromARGB(255, 251, 162, 45)),
      //   const PaymentHistoryPage(),
      // ),

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
            // color: Colors.white,
          ),
          selectedStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
          onTap: () {
            ref.invalidate(profileDataProvider);
            DBRepository handler = DBRepository();

            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            handler.deleteUser(1).then(
                  (_) => context.router.replaceNamed('/login'),
                );
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
        // backgroundColorAppBar: const Color(0xFF1E1E1E),
        disableAppBarDefault: false,
        actionsAppBar: <Widget>[
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                icon: const Icon(Icons.card_giftcard),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('RATE US',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: GoogleFonts.roboto().fontFamily,
                            )),
                        content: Text(
                          'If you like our app, rate us on play store and give us feedback to receive a gift (upcoming additional feature).',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(navRepositoryProvider)
                                  .rateApp()
                                  .then((_) => Navigator.pop(context));
                            },
                            child: const Text(
                              'Rate',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                icon: Icon(
                  ref.watch(themecontrollerProvider) == ThemeMode.light
                      ? Icons.dark_mode
                      : ref.watch(themecontrollerProvider) == ThemeMode.dark
                          ? Icons.brightness_auto
                          : Icons.light_mode,
                ),
                onPressed: () {
                  ref.read(themecontrollerProvider.notifier).changeThemeMode();
                },
              );
            },
          ),
        ],
        // backgroundColorMenu: const Color(0xFF1E1E1E),
        screens: _pages,

        initPositionSelected: 0,
        slidePercent: 50,
        leadingAppBar: const Icon(
          Icons.menu,
          // color: Colors.white,
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
