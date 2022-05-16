import 'package:deliverzler/auth/components/verification/verification_form_component.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class VerificationTextFieldsSection extends HookConsumerWidget {
  const VerificationTextFieldsSection({
    required this.phoneNumberController,
    required this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  final TextEditingController phoneNumberController;

  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: IntlPhoneField(
            style: const TextStyle(
              color: AppColors.grayWhite,
              letterSpacing: 1.5,
            ),
            decoration: InputDecoration(
                border: const OutlineInputBorder(borderSide: BorderSide()),
                fillColor: AppColors.darkThemeTextFieldFillColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Sizes.textFieldDefaultRadius(context)),
                  ),
                  borderSide:
                      const BorderSide(color: AppColors.darkThemePrimary),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Sizes.textFieldDefaultRadius(context)),
                  ),
                  borderSide: const BorderSide(color: AppColors.tertiaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Sizes.textFieldDefaultRadius(context)),
                  ),
                  borderSide: const BorderSide(
                    color: AppColors.darkThemeTextFieldBorderColor,
                  ),
                ),
                errorStyle: const TextStyle(color: AppColors.tertiaryColor),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Sizes.textFieldDefaultRadius(context)),
                  ),
                  borderSide: const BorderSide(color: AppColors.tertiaryColor),
                ),
                filled: true),
            initialCountryCode: 'US',
            onChanged: (mobile) {
              PhoneNumber phoneNumber = PhoneNumber(
                  phoneNumber: mobile.completeNumber,
                  isoCode: mobile.countryISOCode,
                  dialCode: mobile.countryCode);

              ref.read(mobileProvider.notifier).value = phoneNumber;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: AppColors.grayWhite,
          ),
        )
      ],
    );
  }
}
