class Urls {
  // static const String baseUrl = 'https://udode-backend.vercel.app/api/v1';
  // static const String baseUrl = 'https://sports-app-hpbg.onrender.com';
  // static const String baseUrl = 'https://sports-app-dvka.onrender.com';
  // static const String baseUrl = 'https://sports-app-y7lq.onrender.com';
  static const String baseUrl = 'https://sports-app-2b6y.onrender.com';
  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String createProfile = '$baseUrl/users/create-profile';
  static const String fetchProfile = '$baseUrl/auth/getUserById';
  static const String createPlayer = '$baseUrl/players/create-player';
  static const String allPlayers = '$baseUrl/matchLineup/get-lineup-players';
  static const String allPlan = '$baseUrl/admin/plans/get-all-plan';
  static const String otpConfirmation = '$baseUrl/auth/confirmRegistration';
  static String forgateOtpVerifyConfirm(String? email) =>
      '$baseUrl/auth/verify-otp?email=$email';
  static const String verifyOtp = '$baseUrl/auth/verify-otp';
  static String updatePassword(String? email) =>
      '$baseUrl/auth/update-password?email=$email';
  static const String forgotPassword = '$baseUrl/auth/forgot-password';
  static const String updateProfile = '$baseUrl/users/update-profile';
  static const String createMatch = '$baseUrl/matches/create-match';
  static const String updateLogo = '$baseUrl/users/update-logo';
  static const String matchByProfileId = '$baseUrl/matches/all-matches';
  static const String updatelineupplayer =
      '$baseUrl/matchLineup/update-lineup-status';
  static const String calculator = '$baseUrl/setup-game/calculate';
  static const String matchRepot = '$baseUrl/matches/match-report';
  static const String matchPlayerStats = '$baseUrl/matchPlayerStats';
  static const String matchLineupGetLineupPlayers =
      '$baseUrl/matchLineup/get-lineup-players';
  static const String purchasePlan = '$baseUrl/users/purchase-plan';
  static const String verifyPayment =
      '$baseUrl/users/verifyPayment?session_id=';
}
