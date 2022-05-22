import 'package:deliverzler/auth/components/verification/verification_text_fields_section.dart';
import 'package:deliverzler/auth/viewmodels/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_button.dart';
import 'package:deliverzler/core/widgets/loading_indicators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class MobileNumber extends StateNotifier<PhoneNumber> {
  MobileNumber() : super(PhoneNumber(isoCode: 'US'));
  set value(PhoneNumber index) => state = index;
}

final mobileProvider = StateNotifierProvider((ref) => MobileNumber());

class VerificationFormComponent extends HookConsumerWidget {
  const VerificationFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _verificationFormKey = useMemoized(() => GlobalKey<FormState>());
    final _phoneNumberController = useTextEditingController(text: '');

    return Form(
      key: _verificationFormKey,
      child: Column(
        children: [
          VerificationTextFieldsSection(
            phoneNumberController: _phoneNumberController,
            onFieldSubmitted: (value) {
              if (_verificationFormKey.currentState!.validate()) {
                PhoneNumber mobile =
                    ref.read(mobileProvider.notifier) as PhoneNumber;
                ref
                    .watch(authProvider.notifier)
                    .verifyByPhoneNumber(context, mobile: mobile);
              }
            },
          ),
          SizedBox(
            height: Sizes.vMarginSmall(context),
          ),
          Consumer(
            builder: (context, ref, child) {
              final _authLoading = ref.watch(
                authProvider.select((state) =>
                    state.maybeWhen(loading: () => true, orElse: () => false)),
              );
              return _authLoading
                  ? LoadingIndicators.instance.smallLoadingAnimation(
                      context,
                      width: Sizes.loadingAnimationButton(context),
                      height: Sizes.loadingAnimationButton(context),
                    )
                  : CustomButton(
                      text: tr(context).sendOneTimePassword,
                      onPressed: () {
                        if (_verificationFormKey.currentState!.validate()) {
                          PhoneNumber mobile =
                              ref.watch(mobileProvider) as PhoneNumber;
                          ref
                              .watch(authProvider.notifier)
                              .verifyByPhoneNumber(context, mobile: mobile);
                          // NavigationService.pushReplacementAll(
                          //   context,
                          //   isNamed: true,
                          //   page: RoutePaths.authOneTimePassword,
                          //   arguments: {
                          //     "phoneNumber": mobile,
                          //   },
                          // );
                        }
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
