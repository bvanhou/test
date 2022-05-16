import 'package:deliverzler/core/services/platform_service.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

PlatformNavBar? bottomNavBarComponent(
  BuildContext context, {
  required int currentIndex,
  required Function(int) itemChanged,
}) {
  if (PlatformService.instance.isMaterialApp()) return null;
  return PlatformNavBar(
    currentIndex: currentIndex,
    itemChanged: itemChanged,
    items: [
      BottomNavigationBarItem(
        icon: FaIcon(
          FontAwesomeIcons.house,
          size: Sizes.iconsSizes(context)['s5'],
        ),
        label: currentIndex == 0 ? '•' : '',
      ),
      BottomNavigationBarItem(
        icon: FaIcon(
          FontAwesomeIcons.compass,
          size: Sizes.iconsSizes(context)['s5'],
        ),
        label: currentIndex == 1 ? '•' : '',
      ),
      BottomNavigationBarItem(
        icon: FaIcon(
          FontAwesomeIcons.userAstronaut,
          size: Sizes.iconsSizes(context)['s5'],
        ),
        label: currentIndex == 2 ? '•' : '',
      ),
    ],
    backgroundColor:
        Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
            Theme.of(context).bottomAppBarColor,
    material: (_, __) {
      return MaterialNavBarData(
        elevation: 26,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: Sizes.navBarIconRadius(context),
        selectedLabelStyle:
            TextStyle(color: Theme.of(context).colorScheme.primary),
        selectedItemColor: Theme.of(context).colorScheme.primary,
      );
    },
    cupertino: (_, __) {
      return CupertinoTabBarData(
        height: Sizes.cupertinoNavBarHeight(context),
        iconSize: Sizes.navBarIconRadius(context),
        activeColor: Theme.of(context).colorScheme.primary,
      );
    },
  );
}
