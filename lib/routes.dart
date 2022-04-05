import 'package:log_allergy/home/home.dart';
import 'package:log_allergy/login/login.dart';

class Routes {
  static String home = '/';
  static String login = '/login';

  static String getHomeRoute() => home;
  static String getLoginRoute() => login;

  static var appRoutes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
  };
}
