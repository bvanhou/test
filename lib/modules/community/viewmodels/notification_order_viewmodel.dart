import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:deliverzler/core/utils/dialogs.dart';
import 'package:deliverzler/modules/community/repos/orders_repo.dart';
import 'package:deliverzler/modules/community/viewmodels/order_dialogs_viewmodel.dart';

final notificationOrderViewModel = Provider<NotificationOrderViewModel>(
    (ref) => NotificationOrderViewModel(ref));

class NotificationOrderViewModel {
  NotificationOrderViewModel(this.ref);

  Ref ref;

  navigateToNotificationOrder(String notificationOrderId) async {
    final _result = await ref
        .watch(ordersRepoProvider)
        .getOrderById(orderId: notificationOrderId);
    await _result.fold(
      (failure) {
        AppDialogs.showErrorDialog(
          NavigationService.context,
          message: failure?.message,
        );
      },
      (order) async {
        //Few delay to ensure dispose of old map viewmodels.
        await Future.delayed(const Duration(seconds: 1));
        ref.watch(orderDialogsViewModel).setSelectedOrderProvidersAndGoToMap(
              NavigationService.context,
              order,
            );
      },
    );
  }
}
