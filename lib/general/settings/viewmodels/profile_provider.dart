import 'dart:io';

import 'package:deliverzler/auth/repos/user_repo.dart';
import 'package:deliverzler/core/services/image_selector.dart';
import 'package:deliverzler/core/utils/dialogs.dart';
import 'package:deliverzler/general/settings/viewmodels/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

final profileProvider =
    StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(ref);
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this.ref) : super(const ProfileState.available()) {
    _userRepo = ref.read(userRepoProvider);
  }

  final Ref ref;
  late UserRepo _userRepo;

  Future updateProfile(
    BuildContext context, {
    required String username,
    required PhoneNumber mobile,
  }) async {
    state = const ProfileState.loading();
    // PhoneNumberModel _mobile = PhoneNumberModel.fromMap({});
    // final _result = await _userRepo.updateUserData(
    //   _userRepo.userModel!.copyWith(
    //     username: username,
    //     phone: mobile,
    //   ),
    // );
    // await _result.fold(
    //   (failure) {
    //     AppDialogs.showErrorDialog(context, message: failure.message);
    //     state = ProfileState.error(errorText: failure.message);
    //   },
    //   (isSet) async {
    //     if (isSet) {
    //       state = const ProfileState.available();
    //     }
    //   },
    // );
  }

  Future updateProfileImage(
    BuildContext context, {
    required bool fromCamera,
  }) async {
    final _result = await ImageSelector.instance.pickImage(
      context,
      fromCamera: fromCamera,
    );
    _result.fold(
      (failure) {
        AppDialogs.showErrorDialog(context, message: failure.message);
      },
      (pickedFile) {
        if (pickedFile != null) {
          updateFirebaseImage(context, pickedFile);
        }
      },
    );
  }

  updateFirebaseImage(BuildContext context, File? image) async {
    state = const ProfileState.loading();
    final _result = await _userRepo.updateUserImage(image);
    await _result.fold(
      (failure) {
        AppDialogs.showErrorDialog(context, message: failure.message);
        state = ProfileState.error(errorText: failure.message);
      },
      (isSet) async {
        if (isSet) {
          state = const ProfileState.available();
        }
      },
    );
  }
}
