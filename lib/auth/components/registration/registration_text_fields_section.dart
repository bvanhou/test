import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/app_themes/cupertino_custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/utils/validators.dart';
import 'package:deliverzler/core/widgets/custom_text_field.dart';
import 'package:deliverzler/core/styles/sizes.dart';

class RegistrationTextFieldsSection extends StatelessWidget {
  const RegistrationTextFieldsSection({
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.usernameExists,
    required this.decorationState,
    required this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool usernameExists;
  final BorderState decorationState;
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
                decoration:
                    CupertinoCustomTheme.cupertinoFormSectionReactiveDecoration(
                        context,
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
                    key: const ValueKey('registration_email'),
                  ),
                ],
              );
            })),
            SizedBox(height: Sizes.textFieldVMarginDefault(context)),
            Focus(child: Builder(builder: (BuildContext context) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              bool? hadFocus;
              BorderState state = decorationState;
              Icon suffixIcon = Icon(PlatformIcons(context).accountCircle);

              if (hadFocus != null && hadFocus) {
                state = decorationState != BorderState.base
                    ? decorationState
                    : BorderState.focused;
                hadFocus = true;
              }

              if (usernameController.text.isEmpty && hasFocus) {
                if (hasFocus) {
                  state = BorderState.focused;
                } else {
                  state = BorderState.base;
                }
              }

              switch (state) {
                case BorderState.valid:
                  suffixIcon = Icon(PlatformIcons(context).checkMarkCircled,
                      color: AppColors.darkThemeTextFieldValidationColor);
                  break;
                case BorderState.error:
                  suffixIcon = Icon(PlatformIcons(context).error,
                      color: AppColors.darkThemeTextFieldErrorBorderColor);
                  break;
                default:
                  suffixIcon = Icon(PlatformIcons(context).accountCircle);
              }

              return CupertinoFormSection(
                decoration:
                    CupertinoCustomTheme.cupertinoFormSectionReactiveDecoration(
                        context, state),
                backgroundColor: Colors.transparent,
                margin: EdgeInsets.zero,
                children: [
                  CustomTextField(
                    context,
                    controller: usernameController,
                    validator: (v) => usernameExists
                        ? tr(context).usernameAlreadyExists
                        : Validators.instance.validateUsername(v),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    suffixIcon: suffixIcon,
                    hintText: tr(context).username,
                    key: const ValueKey('registration_username'),
                  ),
                ],
              );
            })),
            SizedBox(height: Sizes.textFieldVMarginDefault(context)),
            Focus(child: Builder(builder: (BuildContext context) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              return CupertinoFormSection(
                decoration:
                    CupertinoCustomTheme.cupertinoFormSectionReactiveDecoration(
                        context,
                        hasFocus ? BorderState.focused : BorderState.base),
                backgroundColor: Colors.transparent,
                margin: EdgeInsets.zero,
                children: [
                  CustomTextField(
                    context,
                    controller: passwordController,
                    validator: Validators.instance.validateLoginPassword,
                    textInputAction: TextInputAction.go,
                    obscureText: true,
                    suffixIcon: const Icon(Icons.password),
                    hintText: tr(context).password,
                    key: const ValueKey('registration_password'),
                    onFieldSubmitted: onFieldSubmitted,
                  ),
                ],
              );
            })),
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
        key: const ValueKey('registration_email'),
      ),
      CustomTextField(
        context,
        controller: usernameController,
        validator: (v) => usernameExists
            ? tr(context).usernameAlreadyExists
            : Validators.instance.validateUsername(v),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        suffixIcon: Icon(PlatformIcons(context).accountCircle),
        hintText: tr(context).username,
        key: const ValueKey('registration_username'),
      ),
      CustomTextField(
        context,
        controller: passwordController,
        validator: Validators.instance.validateLoginPassword,
        textInputAction: TextInputAction.go,
        obscureText: true,
        suffixIcon: const Icon(Icons.password),
        hintText: tr(context).password,
        key: const ValueKey('registration_password'),
        onFieldSubmitted: onFieldSubmitted,
      ),
    ];
  }
}
