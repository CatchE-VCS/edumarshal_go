// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:edumarshal/features/auth/view/auth_page.dart' deferred as _i3;
import 'package:edumarshal/features/counter/view/counter_page.dart'
    deferred as _i1;
import 'package:edumarshal/features/home_nav/hidden_drawer_page.dart'
    deferred as _i2;
import 'package:edumarshal/features/splash/view/splash_page.dart' as _i4;
import 'package:edumarshal/features/time_table/time_table_page.dart' as _i5;
import 'package:flutter/foundation.dart' as _i7;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    CounterRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.CounterPage(),
        ),
      );
    },
    HiddenDrawerRoute.name: (routeData) {
      final args = routeData.argsAs<HiddenDrawerRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.HiddenDrawerPage(
            key: args.key,
            accessToken: args.accessToken,
          ),
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.LoginPage(),
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SplashPage(),
      );
    },
    TimeTableRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.TimeTablePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.CounterPage]
class CounterRoute extends _i6.PageRouteInfo<void> {
  const CounterRoute({List<_i6.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HiddenDrawerPage]
class HiddenDrawerRoute extends _i6.PageRouteInfo<HiddenDrawerRouteArgs> {
  HiddenDrawerRoute({
    _i7.Key? key,
    required String accessToken,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          HiddenDrawerRoute.name,
          args: HiddenDrawerRouteArgs(
            key: key,
            accessToken: accessToken,
          ),
          initialChildren: children,
        );

  static const String name = 'HiddenDrawerRoute';

  static const _i6.PageInfo<HiddenDrawerRouteArgs> page =
      _i6.PageInfo<HiddenDrawerRouteArgs>(name);
}

class HiddenDrawerRouteArgs {
  const HiddenDrawerRouteArgs({
    this.key,
    required this.accessToken,
  });

  final _i7.Key? key;

  final String accessToken;

  @override
  String toString() {
    return 'HiddenDrawerRouteArgs{key: $key, accessToken: $accessToken}';
  }
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.TimeTablePage]
class TimeTableRoute extends _i6.PageRouteInfo<void> {
  const TimeTableRoute({List<_i6.PageRouteInfo>? children})
      : super(
          TimeTableRoute.name,
          initialChildren: children,
        );

  static const String name = 'TimeTableRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
