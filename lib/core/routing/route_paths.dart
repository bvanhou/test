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

  //HomeMainNestedRoutes
  static const homeMain = 'community_main';

  //ProfileNestedRoutes
  static const profile = 'profile';
  //SettingsNestedRoutes
  static const settings = 'settings';
  static const settingsLanguage = '$settings/language';
  static const settingsProfile = '$settings/profile';

  //CommunityNestedRoutes
  static const community = 'community';
  static const communityMain = '$community/main';
  static const communityBoard = '$community/board';
  static const communityProfile = '$community/profile';
  static const communityView = '$community/view';
  static const communityPost = '$community/post';

  static const map = '$community/map';

  static const membership = '/membership';
  static const webViewPage = '/webpage';
}
