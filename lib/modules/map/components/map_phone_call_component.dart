import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/utils/validators.dart';
import 'package:deliverzler/modules/map/viewmodels/map_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/utils/dialogs.dart';
import 'package:deliverzler/modules/home/viewmodels/home_state_providers.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapPhoneCallComponent extends ConsumerWidget {
  const MapPhoneCallComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final isArrivedSelectedPlace = ref.watch(isArrivedSelectedPlaceProvider);
    final selectedOrderPhone = ref.watch(selectedOrderProvider)!.userPhone;

    return isArrivedSelectedPlace &&
            selectedOrderPhone.isNotEmpty &&
            Validators.instance.isNumeric(selectedOrderPhone)
        ? Positioned(
            top: Sizes.mapDirectionsInfoTop(context),
            right: Sizes.hPaddingMedium(context),
            child: FloatingActionButton(
              heroTag: const Text('fab2'),
              backgroundColor: AppColors.lightThemePrimary,
              elevation: 2,
              onPressed: () async {
                final _phone = 'tel:$selectedOrderPhone';
                if (await canLaunchUrlString(_phone)) {
                  await launchUrlString(_phone);
                } else {
                  AppDialogs.showErrorDialog(NavigationService.context);
                }
              },
              child: const Icon(
                Icons.phone,
                color: AppColors.white,
              ),
            ),
          )
        : const SizedBox();
  }
}
