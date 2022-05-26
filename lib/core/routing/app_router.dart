import 'package:deliverzler/auth/screens/forgot_password_screen.dart';
import 'package:deliverzler/auth/screens/one_time_password_screen.dart';
import 'package:deliverzler/auth/screens/registration_screen.dart';
import 'package:deliverzler/auth/screens/verification_screen.dart';
import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/routing/navigation_transitions.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/general/settings/screens/profile_screen.dart';
import 'package:deliverzler/modules/community/screens/community_screen.dart';
import 'package:deliverzler/modules/community/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/auth/screens/login_screen.dart';
import 'package:deliverzler/core/screens/no_internet_connection_screen.dart';
import 'package:deliverzler/core/screens/splash_screen.dart';
import 'package:deliverzler/general/settings/screens/language_screen.dart';
import 'package:deliverzler/general/settings/screens/settings_screen.dart';
import 'package:deliverzler/modules/map/screens/map_screen.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AppRouter {
  ///Root Navigator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Core
      case RoutePaths.coreSplash:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case RoutePaths.coreNoInternet:
        final args = settings.arguments as Map?;
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => NoInternetConnection(
            offAll: args?['offAll'],
          ),
          settings: settings,
        );

      //Authentication
      // Login
      case RoutePaths.authLogin:
        return NavigationFadeTransition(
          const LoginScreen(),
          settings: settings,
          transitionDuration: const Duration(seconds: 1),
        );

      // Forgot Password
      case RoutePaths.authForgotPassword:
        return NavigationFadeTransition(
          const ForgotPasswordScreen(),
          settings: settings,
          transitionDuration: const Duration(seconds: 1),
        );

      //Registration
      case RoutePaths.authRegistration:
        return NavigationFadeTransition(
          const RegistrationScreen(),
          settings: settings,
          transitionDuration: const Duration(seconds: 1),
        );

      //One Time Password
      case RoutePaths.authOneTimePassword:
        final args = settings.arguments as Map?;
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => OneTimePasswordScreen(
            phoneNumber: args?['phoneNumber'],
          ),
          settings: settings,
        );

      // Verification
      case RoutePaths.authVerification:
        return NavigationFadeTransition(
          const VerificationScreen(),
          settings: settings,
          transitionDuration: const Duration(seconds: 1),
        );

      // Community
      case RoutePaths.community:
        return NavigationFadeTransition(
          const CommunityScreen(),
          settings: settings,
        );

      //Map
      case RoutePaths.map:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const MapScreen(),
          settings: settings,
        );

      default:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }

  ///Nested Navigators
  // static Route<dynamic> generateHomeMainNestedRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     //Home Page
  //     case RoutePaths.homeMain:
  //       return NavigationFadeTransition(
  //         const OrdersScreen(),
  //         settings: settings,
  //       );

  //     default:
  //       return NavigationFadeTransition(
  //         const OrdersScreen(),
  //         settings: settings,
  //       );
  //   }
  // }

  static Route<dynamic> generateCommunityNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      //Community Page
      case RoutePaths.communityMain:
        return NavigationFadeTransition(
          const MainScreen(),
          settings: settings,
        );

      default:
        return NavigationFadeTransition(
          const SettingsScreen(),
          settings: settings,
        );
    }
  }

  static Route<dynamic> generateProfileNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      //Profile
      case RoutePaths.profile:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );

      default:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );
    }
  }

  static Route<dynamic> generateSettingsNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      //Settings
      case RoutePaths.settings:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );

      case RoutePaths.settingsProfile:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );

      case RoutePaths.settingsLanguage:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const LanguageScreen(),
          settings: settings,
        );

      default:
        return platformPageRoute(
          context: NavigationService.context,
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );
    }
  }
}
