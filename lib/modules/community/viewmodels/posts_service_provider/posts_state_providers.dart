import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/modules/community/models/order_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final communityNavIndexProvider = StateProvider.autoDispose<int>((ref) => 1);

final communityNavRoutesProviders = [
  StateProvider.autoDispose<String>((ref) => RoutePaths.communityMain),
  StateProvider.autoDispose<String>((ref) => RoutePaths.communityBoard),
  StateProvider.autoDispose<String>((ref) => RoutePaths.settings),
];

final selectedOrderProvider = StateProvider<OrderModel?>((ref) => null);
final selectedPlaceGeoPointProvider = StateProvider<GeoPoint?>((ref) => null);
