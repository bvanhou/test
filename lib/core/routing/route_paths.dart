class RoutePaths {
  static const coreSplash = '/';
  static const coreNoInternet = '/no_internet';
  // Authencation Nested Routes
  static const authLogin = '/auth';
  static const authForgotPassword = '/auth/forgot_password';
  static const authResetPassword = '/auth/reset_password';
  static const authVerification = '/auth/verification';
  static const authOneTimePassword = '/auth/oneTimePassword';
  static const authRegistration = '/auth/registration';
  static const authMembershipApplication = '/auth/membershipApplication';

  static const home = '/home';
  static const map = home + '/map';
  //HomeMainNestedRoutes
  static const homeMain = 'home_main';
  //ProfileNestedRoutes
  static const profile = 'profile';
  //SettingsNestedRoutes
  static const settings = 'settings';
  static const settingsLanguage = settings + '/language';
  static const settingsProfile = settings + '/profile';
  //CommunityNestedRoutes
  static const communityMain = '/community/main';
  static const communityBoard = '/community/main/board';

  static const membership = '/membership';
  static const webViewPage = '/webpage';
}
