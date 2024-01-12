import 'package:auto_route/auto_route.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

///Here we used flex color scheme
class Themes {
  static ThemeData get theme => FlexThemeData.light(
        scheme: FlexScheme.material,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        appBarStyle: FlexAppBarStyle.primary,
        blendLevel: 20,
        appBarOpacity: 0.95,
        swapColors: true,
        tabBarStyle: FlexTabBarStyle.forBackground,

        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          blendOnColors: false,
          inputDecoratorRadius: 8,
        ),
        keyColors: const FlexKeyColors(
          useSecondary: true,
          useTertiary: true,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            // replace default CupertinoPageTransitionsBuilder with this
            TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,

        /// fontFamily: GoogleFonts.getFont('Lato').fontFamily,

        ///
      );

  static ThemeData get darkTheme => FlexThemeData.dark(
        scheme: FlexScheme.material,
        appBarStyle: FlexAppBarStyle.material,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        // appBarStyle: FlexAppBarStyle.background,
        appBarOpacity: 0.90,
        tabBarStyle: FlexTabBarStyle.forBackground,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 30,
          inputDecoratorRadius: 8,
        ),
        keyColors: const FlexKeyColors(
          useSecondary: true,
          useTertiary: true,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            // replace default CupertinoPageTransitionsBuilder with this
            TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.getFont('Lato').fontFamily,
      );

// static ThemeData get theme => ThemeData.light(
//       useMaterial3: true,
//     ).copyWith(
//       colorScheme: const ColorScheme.light(
//         primary: Colors.blue,
//         secondary: Colors.blue,
//         background: Colors.white,
//       ),
//       appBarTheme: const AppBarTheme(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         titleTextStyle: TextStyle(
//           color: Colors.black,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Montserrat',
//         ),
//       ),
//     );
//
// static ThemeData get darkTheme => ThemeData.dark(
//       useMaterial3: true,
//     ).copyWith(
//       colorScheme: const ColorScheme.dark(),
//     );
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
}
