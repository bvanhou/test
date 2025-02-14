import 'package:deliverzler/auth/repos/user_repo.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_button.dart';
import 'package:deliverzler/general/settings/components/profile_sections_components/profile_text_fields_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileFormComponent extends HookConsumerWidget {
  const ProfileFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _userModel = ref.watch(userRepoProvider).userModel;
    final _profileFormKey = useMemoized(() => GlobalKey<FormState>());
    final _nameController =
        useTextEditingController(text: _userModel?.username ?? '');
    final _mobileController =
        useTextEditingController(text: _userModel?.phone!.phoneNumber);

    return Form(
      key: _profileFormKey,
      child: Column(
        children: [
          ProfileTextFieldsSection(
            nameController: _nameController,
            mobileController: _mobileController,
          ),
          SizedBox(
            height: Sizes.vMarginHigh(context),
          ),
          CustomButton(
            text: tr(context).confirm,
            onPressed: () {
              if (_profileFormKey.currentState!.validate()) {
                // ref.watch(profileProvider.notifier).updateProfile(
                //       context,
                //       username: _nameController.text,
                //       mobile: _mobileController.text,
                //     );
              }
            },
          ),
        ],
      ),
    );
  }
}
