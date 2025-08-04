import 'package:get/get.dart';



class AppRoute {
  static String splashScreen = '/splashScreen';
  static String welcomeScreen = "/welcomeScreen";
  static String loginScreen = "/loginScreen";
  static String registerScreen = "/registerScreen";
  static String resetPasswordScreen = "/resetPasswordScreen";
  static String forgetScreen = "/forgetScreen";
  static String dashboardScreen = "/dashboardScreen";

  static String getSplashScreen() => splashScreen;
  static String getwelcomeScreen() => welcomeScreen;
  static String getloginScreen() => loginScreen;
  static String getregisterScreen() => registerScreen;
  static String getForgetScreen() => forgetScreen;
  static String getresetPasswordScreen() => resetPasswordScreen;
  static String getdashboardScreen() => dashboardScreen;

  static List<GetPage> routes = [
   // GetPage(name: splashScreen, page: () => SplashScreen()),
   // GetPage(name: welcomeScreen, page: () => WelcomeScreen()),
  //  GetPage(name: dashboardScreen, page: () => Dashboard()),
  ];
}
