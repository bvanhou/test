import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:deliverzler/modules/community/models/order_model.dart';
import 'package:deliverzler/modules/community/repos/orders_repo.dart';

final upcomingOrdersStreamProvider = StreamProvider<List<OrderModel>>((ref) {
  return ref.watch(ordersRepoProvider).getUpcomingOrdersStream();
});
