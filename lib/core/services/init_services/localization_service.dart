import 'package:deliverzler/core/services/init_services/storage_service.dart';
import 'package:deliverzler/core/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final appLocaleProvider = StateProvider<Locale?>((ref) => null);

class LocalizationService {
  LocalizationService._();

  static final instance = LocalizationService._();

  String? _appLocale;

  changeLocale({required String languageCode}) {
    _appLocale = languageCode;
    setUserStoredLocale(languageCode: languageCode);
  }

  Future setUserStoredLocale({required String languageCode}) async {
    (await SharedPreferences.getInstance()).setString(
      StorageKeys.locale,
      languageCode,
    );
  }

  Future<Locale?> getUserStoredLocale() async {
    _appLocale = await StorageService.instance.restoreData(
      key: StorageKeys.locale,
      dataType: DataType.string,
    );
    return _appLocale != null ? Locale(_appLocale!) : null;
  }

  getCurrentLocale() {
    return _appLocale ?? Intl.getCurrentLocale().substring(0, 2);
  }

  bool isAr() {
    if (_appLocale != null) {
      return _appLocale == 'ar';
    } else {
      return Intl.getCurrentLocale().substring(0, 2) == 'ar';
    }
  }
}

AppLocalizations tr(BuildContext context) {
  return AppLocalizations.of(context)!;
}
