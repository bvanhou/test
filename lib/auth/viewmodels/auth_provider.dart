import 'dart:developer';

import 'package:deliverzler/auth/models/user_model.dart';
import 'package:deliverzler/auth/repos/auth_repo.dart';
import 'package:deliverzler/auth/repos/user_repo.dart';
import 'package:deliverzler/auth/viewmodels/auth_state.dart';
import 'package:deliverzler/core/errors/exceptions.dart';
import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/core/services/init_services/firebase_messaging_service.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/utils/dialogs.dart';
import 'package:deliverzler/core/viewmodels/main_core_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

final authProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this.ref) : super(const AuthState.available()) {
    _mainCoreProvider = ref.watch(mainCoreProvider);
    _authRepo = ref.watch(authRepoProvider);
    _userRepo = ref.read(userRepoProvider);
  }

  final Ref ref;
  late MainCoreProvider _mainCoreProvider;
  late AuthRepo _authRepo;
  late UserRepo _userRepo;

  // Basic Authentication Flow
  signInWithEmailAndPassword(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    NavigationService.removeAllFocus(context);
    final _result = await _authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _result.fold(
      (failure) {
        state = AuthState.error(errorText: failure.message);
        AppDialogs.showErrorDialog(context, message: failure.message);
      },
      (user) async {
        UserModel userModel = user;
        await submitLogin(context, userModel: userModel);
      },
    );
  }

  createUserWithEmailAndPassword(
    BuildContext context, {
    required String email,
    required String password,
    required String username,
  }) async {
    state = const AuthState.loading();
    NavigationService.removeAllFocus(context);
    final _result = await _authRepo.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _result.fold(
      (failure) {
        state = AuthState.error(errorText: failure.message);
        AppDialogs.showErrorDialog(context, message: failure.message);
      },
      (user) async {
        UserModel userModel = user;
        userModel.username = username;
        await _userRepo.setUserData(userModel);
        await submitLogin(context, userModel: userModel);
      },
    );
  }

  Future submitLogin(BuildContext context,
      {required UserModel userModel, bool? forgotPassword}) async {
    final _result = await _mainCoreProvider.setUserToFirebase(userModel);
    await _result.fold(
      (failure) {
        state = AuthState.error(errorText: failure.message);
        AppDialogs.showErrorDialog(context, message: failure.message);
      },
      (isSet) async {
        // CommunityModel? _community =
        //           await _mainCoreVM.getCommunityDataFromFirebaseByName();
        //       _mainCoreVM.setCurrentCommunity(communityModel: _community!);
        state = const AuthState.available();
        if (forgotPassword != null && forgotPassword) {
          log("Forgot Password - Navigating to Reset Password Screen");
          navigationToChangePasswordScreen(context);
        } else if (userModel.phoneVerified!) {
          if (!userModel.hasApplied!) {
            log("User has not yet applied to the community - Navigating to Membership Application Screen");
            navigationToApplicationScreen(context);
          } else {
            log("User Successfully logged in - Navigating to Home Screen");
            subscribeUserToTopic();
            navigationToHomeScreen(context);
          }
        } else {
          log("User has not yet had their phone verified - Navigating to Verification Screen");
          navigationToVerificationScreen(context);
        }
      },
    );
  }

  // Advanced Authentication Flow
  verifyByPhoneNumber(BuildContext context,
      {required PhoneNumber mobile, bool? resend}) async {
    state = const AuthState.loading();
    NavigationService.removeAllFocus(context);
    PhoneNumber _number = await PhoneNumber.getRegionInfoFromPhoneNumber(
        mobile.phoneNumber!, mobile.isoCode!);
    final _result = await _authRepo.verificationByPhoneNumber(
        mobile: _number,
        timeout: const Duration(
          seconds: 120,
        ));
    await _result.fold(
      (failure) {
        state = AuthState.error(errorText: failure.message);
        AppDialogs.showErrorDialog(context, message: failure.message);
      },
      (verificationState) async {
        state = const AuthState.available();
        final _results = await verificationState;
        if (_results is FirebaseAuthException) {
          FirebaseAuthException _exception = _results;
          final _errorMessage = Exceptions.firebaseAuthErrorMessage(_exception);
          AppDialogs.showErrorDialog(context, message: _errorMessage);
        } else {
          log("Transitioning to OTP");
          resend ??
              navigationToOneTimePasswordScreen(context, phoneNumber: _number);
        }
      },
    );
  }

  verificationWithOneTimePassword(BuildContext context,
      {required String otp, required bool hasForgotPassword}) async {
    if (_userRepo.userModel != null) {
      log("Verification Flow - Verified User - Signing into account");
      final _result = await _authRepo.signInWithVerificationCode(otp: otp);
      await _result.fold(
        (failure) {
          state = AuthState.error(errorText: failure.message);
          AppDialogs.showErrorDialog(context, message: failure.message);
        },
        (_) async {
          UserModel userModel = _userRepo.userModel!;
          userModel.phoneVerified = true;
          await _userRepo.setUserData(userModel);
          await submitLogin(context, userModel: userModel);
        },
      );
    } else {
      log("Forgot Password Flow - Verified User - Signing into account");
      final _result = await _authRepo.signInWithVerificationCode(otp: otp);
      await _result.fold(
        (failure) {
          state = AuthState.error(errorText: failure.message);
          AppDialogs.showErrorDialog(context, message: failure.message);
        },
        (user) async {
          UserModel userModel = user;
          await _userRepo.setUserData(userModel);
          await submitLogin(context, userModel: userModel);
        },
      );
    }
  }

  // Forgot Password
  forgotPassword(
    BuildContext context, {
    required String email,
  }) async {
    try {
      state = const AuthState.loading();
      NavigationService.removeAllFocus(context);
      await FirebaseAuth.instance.signInAnonymously();
      final _result = await _userRepo.getUserDataByEmailAddress(email);
      await FirebaseAuth.instance.currentUser!.delete();
      await FirebaseAuth.instance.signOut();
      await _result.fold(
        (failure) {
          state = AuthState.error(errorText: failure.message);
          AppDialogs.showErrorDialog(context, message: failure.message);
        },
        (user) async {
          UserModel userModel = user;
          PhoneNumber _mobile = PhoneNumber(
              phoneNumber: userModel.phone!.phoneNumber,
              isoCode: userModel.phone!.isoCode,
              dialCode: userModel.phone!.dialCode);
          await verifyByPhoneNumber(context, mobile: _mobile);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      AppDialogs.showErrorDialog(context,
          message: tr(context).unableToCompleteRequest);
    }
  }

  // Check Username
  Future<bool> checkUsernameExists(String? username) async {
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('checkUsernames');

      HttpsCallableResult resp =
          await callable.call(<String, dynamic>{"username": username});
      Map<String, dynamic> data = resp.data;
      return !data['result'];
    } catch (e) {
      log(e.toString());
      return false;
      // Do other things that might be thrown that I have overlooked
    }
  }

  // Notification Modules
  subscribeUserToTopic() {
    FirebaseMessagingService.instance.subscribeToTopic(
      topic: 'general',
    );
  }

  // Navigation Routes
  navigationToHomeScreen(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.home,
    );
  }

  navigationToApplicationScreen(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.authMembershipApplication,
    );
  }

  navigationToUserProfileScreen(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.profile,
    );
  }

  navigationToChangePasswordScreen(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.authResetPassword,
    );
  }

  navigationToVerificationScreen(BuildContext context) {
    NavigationService.pushReplacementAll(
      context,
      isNamed: true,
      page: RoutePaths.authVerification,
    );
  }

  navigationToOneTimePasswordScreen(BuildContext context,
      {required PhoneNumber phoneNumber}) {
    NavigationService.pushReplacementAll(context,
        isNamed: true,
        page: RoutePaths.authOneTimePassword,
        arguments: {
          "phoneNumber": phoneNumber,
        });
  }
}
