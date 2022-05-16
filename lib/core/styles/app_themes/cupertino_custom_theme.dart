import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/material.dart';

enum borderState { valid, focused, error, base }

class CupertinoCustomTheme {
  static BoxDecoration cupertinoFormSectionDecoration(BuildContext context) =>
      BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            Sizes.textFieldDefaultRadius(context),
          ),
        ),
        border: Border.all(
          color:
              Theme.of(context).inputDecorationTheme.border!.borderSide.color,
        ),
      );

  static BoxDecoration cupertinoFormSectionReactiveDecoration(
      BuildContext context, borderState state) {
    BoxDecoration? decoration;
    switch (state) {
      case borderState.valid:
        decoration = BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                Sizes.textFieldDefaultRadius(context),
              ),
            ),
            border: Border.all(
              color: Theme.of(context)
                  .inputDecorationTheme
                  .enabledBorder!
                  .borderSide
                  .color,
            ));
        break;
      case borderState.focused:
        decoration = BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                Sizes.textFieldDefaultRadius(context),
              ),
            ),
            border: Border.all(
              color: Theme.of(context)
                  .inputDecorationTheme
                  .focusedBorder!
                  .borderSide
                  .color,
            ));
        break;
      case borderState.error:
        decoration = BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                Sizes.textFieldDefaultRadius(context),
              ),
            ),
            border: Border.all(
              color: Theme.of(context)
                  .inputDecorationTheme
                  .errorBorder!
                  .borderSide
                  .color,
            ));
        break;
      default:
        decoration = BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                Sizes.textFieldDefaultRadius(context),
              ),
            ),
            border: Border.all(
              color: Theme.of(context)
                  .inputDecorationTheme
                  .border!
                  .borderSide
                  .color,
            ));
    }
    return decoration;
  }
}
