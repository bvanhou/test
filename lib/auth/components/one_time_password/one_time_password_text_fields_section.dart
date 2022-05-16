import 'dart:async';

import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OneTimePasswordTextFieldsSection extends StatelessWidget {
  const OneTimePasswordTextFieldsSection({
    required this.codeController,
    required this.errorController,
    Key? key,
  }) : super(key: key);

  final TextEditingController codeController;
  final StreamController<ErrorAnimationType> errorController;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Column(
          children: [
            PinCodeTextField(
              appContext: context,
              pastedTextStyle: const TextStyle(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                fieldHeight: 45,
                fieldWidth: 45,
                activeColor: AppColors.darkThemePrimary,
                selectedFillColor: AppColors.darkThemeTextFieldFillColor,
                activeFillColor: AppColors.darkThemeTextFieldFillColor,
                inactiveColor: AppColors.darkGray,
                selectedColor: AppColors.darkThemePrimary,
                inactiveFillColor: AppColors.darkThemeTextFieldFillColor,
                borderRadius: BorderRadius.circular(5),
                borderWidth: 2,
              ),
              enablePinAutofill: true,
              cursorColor: AppColors.grayWhite,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: codeController,
              keyboardType: TextInputType.number,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) {
                // print(v);
              },
              onChanged: (value) {
                // print(value);
              },
              beforeTextPaste: (text) {
                // debugPrint("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
            SizedBox(height: Sizes.textFieldVMarginDefault(context)),
          ],
        ));
  }
}
