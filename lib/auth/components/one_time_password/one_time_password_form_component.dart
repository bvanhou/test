import 'package:deliverzler/auth/components/one_time_password/one_time_password_text_fields_section.dart';
import 'package:deliverzler/auth/viewmodels/auth_provider.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_button.dart';
import 'package:deliverzler/core/widgets/loading_indicators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OneTimePasswordFormComponent extends HookConsumerWidget {
  final PhoneNumber phoneNumber;
  const OneTimePasswordFormComponent({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _oneTimePasswordFormKey = useMemoized(() => GlobalKey<FormState>());
    final _codeController = useTextEditingController(text: '');
    final _errorController = useStreamController<ErrorAnimationType>();

    return Form(
      key: _oneTimePasswordFormKey,
      child: Column(
        children: [
          OneTimePasswordTextFieldsSection(
            codeController: _codeController,
            errorController: _errorController,
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
                      text: tr(context).verifyAccount,
                      onPressed: () {
                        if (_oneTimePasswordFormKey.currentState!.validate()) {
                          ref
                              .watch(authProvider.notifier)
                              .verificationWithOneTimePassword(context,
                                  otp: _codeController.text.trim(),
                                  hasForgotPassword: false);
                        }
                      },
                    );
            },
          ),
          SizedBox(
            height: Sizes.vMarginSmall(context),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextButton(
                child: CustomText.h5(
                  context,
                  tr(context).resend,
                  color: AppColors.accentColor,
                  weight: FontStyles.fontWeightSemiBold,
                  alignment: Alignment.center,
                ),
                elevation: 1,
                minWidth: Sizes.textButtonMinWidth(context),
                minHeight: Sizes.textButtonMinHeight(context),
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                buttonColor: Colors.transparent,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () async {
                  _codeController.clear();
                  ref.watch(authProvider.notifier).verifyByPhoneNumber(context,
                      mobile: phoneNumber, resend: true);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
