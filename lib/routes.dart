import 'package:log_allergy/home/home.dart';
import 'package:log_allergy/login/login.dart';
import 'package:log_allergy/profile/profile.dart';

class Routes {
  static String home = '/';
  static String login = '/login';
  static String profile = '/profile';

  static String getHomeRoute() => home;
  static String getLoginRoute() => login;
  static String getProfileRoute() => login;

  static var appRoutes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    profile: (context) => const ProfileScreen(),
  };
}
