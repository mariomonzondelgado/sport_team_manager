import 'package:sport_team_manager/ui/screen/login_screen/login_screen.dart';
import 'package:sport_team_manager/ui/screen/register_screen/register_screen.dart';
import 'package:sport_team_manager/ui/screen/splash_screen/splash_screen.dart';
import 'package:sport_team_manager/ui/screen/tabs_screen/tabs_screen.dart';

final routeMap = {
  '/splash_screen': (_) => SplashScreen(),
  // '/homescreen': (_) => HomeScreen(),
  '/login_screen': (_) => LoginScreen(),
  '/register_screen': (_) => RegisterScreen(),
  '/tabs_screen': (_) => TabsScreen(),
};
