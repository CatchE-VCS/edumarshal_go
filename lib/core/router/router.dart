import 'package:auto_route/auto_route.dart';
import 'package:edumarshal/core/router/router.gr.dart';

/// This class used for defined routes and paths na dother properties
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  late final List<AutoRoute> routes = [
    AutoRoute(
      page: CounterRoute.page,
      path: '/counter',
    ),
    AutoRoute(
      page: SplashRoute.page,
      path: '/',
      initial: true,
    ),
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
    ),
    AutoRoute(
      page: HiddenDrawerRoute.page,
      path: '/hidden-drawer',
    ),
  ];
}
