import 'package:deliverzler/core/styles/app_themes/cupertino_custom_theme.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/utils/validators.dart';
import 'package:deliverzler/core/widgets/custom_text_field.dart';

class ForgotPasswordTextFieldsSection extends StatelessWidget {
  const ForgotPasswordTextFieldsSection({
    required this.emailController,
    required this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  final TextEditingController emailController;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (_, __) {
        return Column(
          children: _sharedItemComponent(context),
        );
      },
      cupertino: (_, __) {
        return Column(
          children: [
            Focus(child: Builder(builder: (BuildContext context) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              return CupertinoFormSection(
                  decoration: CupertinoCustomTheme
                      .cupertinoFormSectionReactiveDecoration(context,
                          hasFocus ? BorderState.focused : BorderState.base),
                  backgroundColor: Colors.transparent,
                  margin: EdgeInsets.zero,
                  children: [
                    CustomTextField(
                      context,
                      controller: emailController,
                      validator: Validators.instance.validateEmail,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: Icon(PlatformIcons(context).mail),
                      hintText: tr(context).email,
                      key: const ValueKey('forgotPassword_email'),
                    ),
                  ]);
            })),
            SizedBox(height: Sizes.textFieldVMarginDefault(context)),
          ],
        );
      },
    );
  }

  _sharedItemComponent(BuildContext context) {
    return [
      CustomTextField(
        context,
        controller: emailController,
        validator: Validators.instance.validateEmail,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        suffixIcon: Icon(PlatformIcons(context).mail),
        hintText: tr(context).email,
        key: const ValueKey('forgotPassword_email'),
      ),
    ];
  }
}
