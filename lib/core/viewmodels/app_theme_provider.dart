import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:deliverzler/core/services/init_services/storage_service.dart';
import 'package:deliverzler/core/utils/storage_keys.dart';

final appThemeProvider =
    StateNotifierProvider<AppThemeNotifier, ThemeMode?>((ref) {
  return AppThemeNotifier();
});

class AppThemeNotifier extends StateNotifier<ThemeMode> {
  AppThemeNotifier() : super(ThemeMode.system);

  init() async {
    await getUserStoredTheme();
  }

  Future getUserStoredTheme() async {
    late ThemeMode _themeMode;
    final _storedTheme = await StorageService.instance.restoreData(
      key: StorageKeys.theme,
      dataType: DataType.string,
    );
    if (_storedTheme != null) {
      _themeMode = _storedTheme == 'light' ? ThemeMode.light : ThemeMode.dark;
      state = _themeMode;
    }
  }

  changeTheme({required bool isLight}) {
    final _theme = isLight ? ThemeMode.light : ThemeMode.dark;
    state = _theme;
    setUserStoredTheme(_theme);
  }

  Future setUserStoredTheme(ThemeMode themeMode) async {
    final theme = themeMode == ThemeMode.light ? 'light' : 'dark';
    await StorageService.instance.saveData(
      value: theme,
      key: StorageKeys.theme,
      dataType: DataType.string,
    );
  }
}
