import 'package:deliverzler/modules/community/models/community_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/modules/community/viewmodels/order_dialogs_viewmodel.dart';

class CardItemComponent extends ConsumerWidget {
  const CardItemComponent({
    required this.orderModel,
    Key? key,
  }) : super(key: key);

  final CommunityModel orderModel;

  @override
  Widget build(BuildContext context, ref) {
    final orderDialogsVM = ref.watch(orderDialogsViewModel);
    // final bool _isUpcomingOrder = orderModel.orderDeliveryStatus ==
    //     describeEnum(OrderDeliveryStatus.upcoming);

    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.cardRadius(context)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.cardVPadding(context),
          horizontal: Sizes.cardHRadius(context),
        ),
        child: Column(
          children: const [],
        ),
      ),
    );
  }
}
