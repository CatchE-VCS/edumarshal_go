// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:edumarshal/features/auth/view/auth_page.dart' deferred as _i3;
import 'package:edumarshal/features/counter/view/counter_page.dart'
    deferred as _i1;
import 'package:edumarshal/features/home_nav/hidden_drawer_page.dart'
    deferred as _i2;
import 'package:edumarshal/features/splash/view/splash_page.dart'
    deferred as _i4;
import 'package:edumarshal/features/time_table/time_table_page.dart' as _i5;
import 'package:edumarshal/features/what_we_have_done/view/what_we_have_done_page.dart'
    deferred as _i6;
import 'package:flutter/foundation.dart' as _i8;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    CounterRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.CounterPage(),
        ),
      );
    },
    HiddenDrawerRoute.name: (routeData) {
      final args = routeData.argsAs<HiddenDrawerRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.HiddenDrawerPage(
            key: args.key,
            accessToken: args.accessToken,
          ),
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.LoginPage(),
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.SplashPage(),
        ),
      );
    },
    TimeTableRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.TimeTablePage(),
      );
    },
    WhatWeHaveDoneRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.WhatWeHaveDonePage(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CounterPage]
class CounterRoute extends _i7.PageRouteInfo<void> {
  const CounterRoute({List<_i7.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HiddenDrawerPage]
class HiddenDrawerRoute extends _i7.PageRouteInfo<HiddenDrawerRouteArgs> {
  HiddenDrawerRoute({
    _i8.Key? key,
    required String accessToken,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          HiddenDrawerRoute.name,
          args: HiddenDrawerRouteArgs(
            key: key,
            accessToken: accessToken,
          ),
          initialChildren: children,
        );

  static const String name = 'HiddenDrawerRoute';

  static const _i7.PageInfo<HiddenDrawerRouteArgs> page =
      _i7.PageInfo<HiddenDrawerRouteArgs>(name);
}

class HiddenDrawerRouteArgs {
  const HiddenDrawerRouteArgs({
    this.key,
    required this.accessToken,
  });

  final _i8.Key? key;

  final String accessToken;

  @override
  String toString() {
    return 'HiddenDrawerRouteArgs{key: $key, accessToken: $accessToken}';
  }
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.TimeTablePage]
class TimeTableRoute extends _i7.PageRouteInfo<void> {
  const TimeTableRoute({List<_i7.PageRouteInfo>? children})
      : super(
          TimeTableRoute.name,
          initialChildren: children,
        );

  static const String name = 'TimeTableRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.WhatWeHaveDonePage]
class WhatWeHaveDoneRoute extends _i7.PageRouteInfo<void> {
  const WhatWeHaveDoneRoute({List<_i7.PageRouteInfo>? children})
      : super(
          WhatWeHaveDoneRoute.name,
          initialChildren: children,
        );

  static const String name = 'WhatWeHaveDoneRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
