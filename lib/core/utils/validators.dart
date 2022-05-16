import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/services/localization_service.dart';

class Validators {
  Validators._();

  static final Validators instance = Validators._();

  String? validateMobileNumber(String? value) {
    Pattern patternMobileNumber =
        r'^(?:[+0]9)?[0-9|٩|٠|١|٢|٣|٤|٥|٦|٧|٨]{10,15}$';

    String val = value!.trim();
    if (val.isEmpty) {
      return tr(NavigationService.context).thisFieldIsEmpty;
    } else if (val.contains("+") &&
        val.contains(RegExp(r'[0-9]|٩|٠|١|٢|٣|٤|٥|٦|٧|٨')) &&
        !val.contains(RegExp(r'[a-zA-Z]')) &&
        !val.contains(RegExp(r'[ء-ي]'))) {
      return tr(NavigationService.context).pleaseEnterValidNumber;
    } else if (!val.contains(RegExp(r'[a-zA-Z]')) &&
        val.contains(RegExp(r'[0-9]|٩|٠|١|٢|٣|٤|٥|٦|٧|٨')) &&
        !val.contains("+") &&
        !val.contains(RegExp(r'[ء-ي]'))) {
      if (!checkPattern(pattern: patternMobileNumber, value: value)) {
        return tr(NavigationService.context).pleaseEnterValidNumber;
      }
    }
    return null;
  }

  String? validateName(String? value) {
    //english name: r'^[a-zA-Z,.\-]+$'
    //arabic name: r'^[\u0621-\u064A\040]+$'
    //english and arabic names
    String patternName = r"^[\u0621-\u064A\040\a-zA-Z,.\-]+$";
    if (value!.isEmpty) {
      return tr(NavigationService.context).thisFieldIsEmpty;
    } else if (value.toString().length < 2) {
      return tr(NavigationService.context).nameMustBeAtLeast2Letters;
    } else if (value.toString().length > 30) {
      return tr(NavigationService.context).nameMustBeAtMost30Letters;
    } else if (!checkPattern(pattern: patternName, value: value)) {
      return tr(NavigationService.context).pleaseEnterValidName;
    } else {
      return null;
    }
  }

  String? validateUsername(String? value) {
    String patternName =
        r"^(?=.{2,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$";

    if (value!.isEmpty) {
      return tr(NavigationService.context).thisFieldIsEmpty;
    } else if (value.toString().length < 3) {
      return tr(NavigationService.context).nameMustBeAtLeast2Letters;
    } else if (value.toString().length > 19) {
      return tr(NavigationService.context).nameMustBeAtMost20Letters;
    } else if (!checkPattern(pattern: patternName, value: value)) {
      return tr(NavigationService.context).pleaseEnterValidUserName;
    }
    return null;
  }

  String? validateEmail(String? value) {
    String _patternEmail =
        r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
    bool _checkPattern = checkPattern(pattern: _patternEmail, value: value);

    if (value!.isEmpty) {
      return tr(NavigationService.context).thisFieldIsEmpty;
    } else if (!_checkPattern) {
      return tr(NavigationService.context).pleaseEnterValidEmail;
    } else {
      return null;
    }
  }

  String? validateLoginPassword(String? value) {
    if (value!.isEmpty) {
      return tr(NavigationService.context).thisFieldIsEmpty;
    } else {
      return null;
    }
  }

  bool isNumeric(String str) {
    Pattern patternInteger = r'^-?[0-9]+$';
    return checkPattern(pattern: patternInteger, value: str);
  }

  bool checkPattern({pattern, value}) {
    RegExp regularCheck = RegExp(pattern);
    return regularCheck.hasMatch(value);
  }
}
