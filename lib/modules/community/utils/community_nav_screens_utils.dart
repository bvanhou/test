import 'package:deliverzler/core/routing/app_router.dart';
import 'package:deliverzler/core/routing/navigator_route_observer.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/modules/community/screens/nested_navigator_screen.dart';
import 'package:deliverzler/modules/community/viewmodels/community_service_provider/community_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class CommunityNavScreensUtils {
  static final communityNavScreensKeys = [
    GlobalKey<NavigatorState>(debugLabel: 'page1'),
    GlobalKey<NavigatorState>(debugLabel: 'page2'),
    GlobalKey<NavigatorState>(debugLabel: 'page3'),
  ];

  static communityNavScreens(WidgetRef ref) => [
        //Nested Navigator for persistent bottom navigation bar
        NestedNavigatorScreen(
          navigatorKey: communityNavScreensKeys[0],
          screenPath: RoutePaths.profile,
          onGenerateRoute: AppRouter.generateProfileNestedRoute,
          routeObserver: _communityNavScreensRouteObserver(0, ref),
        ),
        NestedNavigatorScreen(
          navigatorKey: communityNavScreensKeys[1],
          screenPath: RoutePaths.communityMain,
          onGenerateRoute: AppRouter.generateCommunityNestedRoute,
          routeObserver: _communityNavScreensRouteObserver(1, ref),
        ),
        NestedNavigatorScreen(
          navigatorKey: communityNavScreensKeys[2],
          screenPath: RoutePaths.settings,
          onGenerateRoute: AppRouter.generateSettingsNestedRoute,
          routeObserver: _communityNavScreensRouteObserver(2, ref),
        ),
      ];

  static _communityNavScreensRouteObserver(int index, WidgetRef ref) =>
      NavigatorRouteObserver(
        onPush: (Route? route, Route? previousRoute) {
          final _navNotifier =
              ref.read(communityNavRoutesProviders[index].notifier);
          _navNotifier.state = route!.settings.name!;
        },
        onReplace: (Route? route, Route? previousRoute) {
          final _navNotifier =
              ref.read(communityNavRoutesProviders[index].notifier);
          _navNotifier.state = route!.settings.name!;
        },
        onPop: (Route? route, Route? previousRoute) {
          final _navNotifier =
              ref.read(communityNavRoutesProviders[index].notifier);
          _navNotifier.state = previousRoute!.settings.name!;
        },
      );
}
