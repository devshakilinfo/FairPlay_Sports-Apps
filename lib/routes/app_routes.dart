import 'package:get/get.dart';
import 'package:sports_apps/features/authentication/presentation/screens/login_screen.dart';
import 'package:sports_apps/features/home/screen/my_team.dart';
import 'package:sports_apps/features/navigation_ber/screen/bottom_navigation_ber.dart';
import 'package:sports_apps/features/onbording/screen/welcome_screen.dart';
import 'package:sports_apps/features/settings/screen/setting_screen.dart';
import 'package:sports_apps/features/splaso_screen/screen/splaso_screen.dart';
import 'package:sports_apps/features/subscription_plan/screen/subscription_plan_screen.dart'
    show SubscriptionPlanScreen;

import '../features/authentication/presentation/screens/otp_send_screen.dart'
    show OtpSendScreen;
import '../features/authentication/presentation/screens/signup_screen.dart'
    show SignupScreen;
import '../features/games_setup/screen/calculate_time.dart' show CalculateTime;
import '../features/games_setup/screen/games_setup.dart' show GamesSetup;
import '../features/home/screen/games_lineup.dart' show GamesLineup;
import '../features/home/screen/games_lineup/screen/games_lineup_screen.dart'
    show GamesLineupScreen;
import '../features/home/screen/games_lineup/screen/game_lineup_2.dart'
    show GamesLineup2;
import '../features/home/screen/games_lineup/screen/palyer_historty2.dart'
    show PlayerHistory2;
import '../features/home/screen/manage_lineup.dart' show ManageLineup;
import '../features/home/screen/player_history.dart' show PlayerHistory;
import '../features/payment/screen/payment_screen.dart' show PaymentScreen;
import '../features/profile/screen/profile_screen.dart' show ProfileScreen;
import '../features/user_profile/screen/user_profile_screen.dart'
    show UserProfileScreen;

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String welcomescreen = '/welcomeScreen';
  static String loginScreen = '/loginScreen';
  static String signupScreen = '/signupScreen';
  static String otpSendScreen = '/otpSendScreen';
  static String changedPassword = '/changedPassword';
  static String subscriptionPlanScreen = '/subscriptionPlanScreen';
  static String paymentScreen = '/paymentScreen';
  static String profileScreen = '/profileScreen';
  static String manageLineup = '/manageLineup';
  static String myTeam = '/myTeam';
  static String gamesLineup = '/gamesLineup';
  static String userProfileScreen = '/userProfileScreen';
  static String playerHistory = '/playerHistory';
  static String gamesLineupScreen = '/gamesLineupScreen';
  static String gamesLineup2 = '/gamesLineup2';
  static String playerHistory2 = '/playerHistory2';
  static String gamesSetup = '/gamesSetup';
  static String calculateTime = '/calculateTime';
  static String settingScreen = '/settingScreen';
  static String bottomnavbar = '/bottomnavbar';

  static String getLSplashScreen() => splashScreen;
  static String getWelcomeScreen() => welcomescreen;
  static String getLoginScreen() => loginScreen;
  static String getsignupScreen() => signupScreen;
  static String getotpSendScreen() => otpSendScreen;
  static String getsubscriptionPlanScreen() => subscriptionPlanScreen;
  static String getPaymentScreen() => paymentScreen;
  static String getprofileScreen() => profileScreen;
  static String getmanageLineup() => manageLineup;
  static String getmyTeam() => myTeam;
  static String getgamesLineup() => gamesLineup;
  static String getuserProfileScreen() => userProfileScreen;
  static String getplayerHistory() => playerHistory;
  static String getgamesLineupScreen() => gamesLineupScreen;
  static String getgamesLineup2() => gamesLineup2;
  static String getplayerHistory2() => playerHistory2;
  static String getgamesSetup() => gamesSetup;
  static String getcalculateTime() => calculateTime;
  static String getsettingScreen() => settingScreen;
  static String getbottomnavbar() => bottomnavbar;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: welcomescreen, page: () => const WelcomeScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signupScreen, page: () => SignupScreen()),
    GetPage(name: otpSendScreen, page: () => OtpSendScreen()),
    GetPage(name: subscriptionPlanScreen, page: () => SubscriptionPlanScreen()),
    GetPage(name: paymentScreen, page: () => PaymentScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: manageLineup, page: () => ManageLineup()),
    GetPage(name: myTeam, page: () => MyTeam()),
    GetPage(name: gamesLineup, page: () => GamesLineup()),
    GetPage(name: userProfileScreen, page: () => UserProfileScreen()),
    GetPage(name: playerHistory, page: () => PlayerHistory()),
    GetPage(name: gamesLineupScreen, page: () => GamesLineupScreen()),
    GetPage(name: gamesLineup2, page: () => GamesLineup2()),
    GetPage(name: playerHistory2, page: () => PlayerHistory2()),
    GetPage(name: gamesSetup, page: () => GamesSetup()),
    GetPage(name: calculateTime, page: () => CalculateTime()),
    GetPage(name: settingScreen, page: () => SettingScreen()),
    GetPage(name: bottomnavbar, page: () => BottomNavbar()),
  ];
}
