import 'package:edumarshal/app/app.dart';
import 'package:edumarshal/bootstrap.dart';

/// This entry point should be used for production only
// import 'controllers/model.dart';
//
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  ///You can override your environment variable in bootstrap method here for providers
  bootstrap(() => const App());
}
