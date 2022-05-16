import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/utils/dialog_message_state.dart';
import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  static Future showErrorDialog(BuildContext context, {String? message}) async {
    await DialogWidget.showCustomDialog(
      context: context,
      dialogWidgetState: DialogWidgetState.error,
      title: tr(context).oops,
      description: tr(context).somethingWentWrong +
          '\n' +
          (message ?? tr(context).pleaseTryAgainLater),
      textButton: tr(context).oK,
      onPressed: () {
        NavigationService.goBack(context);
      },
    );
  }

  //  static Future showOperationCanceledDialog() async {
  //   await DialogWidget.showCustomDialog(
  //     context: Get.context!,
  //     dialogWidgetState: DialogWidgetState.error,
  //     title: tr('operationCanceledByUser'),
  //     textButton: tr('OK'),
  //     onPressed: () {
  //       NavigationService.goBack();
  //     },
  //   );
  // }

  // static Future showEmailOrPassIncorrectDialog() async {
  //   DialogWidget.showCustomDialog(
  //     context: Get.context!,
  //     dialogWidgetState: DialogWidgetState.error,
  //     title: tr('emailOrPasswordIsInCorrect'),
  //     textButton: tr('OK'),
  //     onPressed: () {
  //       NavigationService.goBack();
  //     },
  //   );
  // }

  // static Future showWeakPasswordDialog() async {
  //   await DialogWidget.showCustomDialog(
  //     context: Get.context!,
  //     dialogWidgetState: DialogWidgetState.error,
  //     title: tr('oops'),
  //     description: tr('weakPassword'),
  //     textButton: tr('OK'),
  //     onPressed: () {
  //       NavigationService.goBack();
  //     },
  //   );
  // }

  // static Future showRequiresAuthentication() async {
  //   await DialogWidget.showCustomDialog(
  //     context: Get.context!,
  //     dialogWidgetState: DialogWidgetState.error,
  //     title: tr('oops'),
  //     description: tr('reauthenticationRequired'),
  //     textButton: tr('OK'),
  //     onPressed: () async {
  //       await FirebaseAuthAPI.instance.signOut();
  //       NavigationService.offAll(
  //         isNamed: true,
  //         page: RoutePaths.authLogin,
  //       );
  //     },
  //   );
  // }

  // static Future showUpdatePasswordSuccess() async {
  //   await DialogWidget.showCustomDialog(
  //     context: Get.context!,
  //     dialogWidgetState: DialogWidgetState.success,
  //     title: tr('success'),
  //     description: tr('updatedPassword'),
  //     textButton: tr('OK'),
  //     onPressed: () async {
  //       NavigationService.offAll(
  //         isNamed: true,
  //         page: RoutePaths.profile,
  //       );
  //     },
  //   );
  // }

  // static Future showExpiredSession(String message) async {
  //   await DialogWidget.showCustomDialog(
  //     context: Get.context!,
  //     dialogWidgetState: DialogWidgetState.error,
  //     title: tr('oops'),
  //     description: message,
  //     textButton: tr('OK'),
  //     onPressed: () {
  //       NavigationService.goBack();
  //     },
  //   );
  // }

  // static Future showApplicationDialog() async {
  //   return await DialogWidget.showCustomDialog(
  //       context: Get.context!,
  //       title: tr('communityUnlock'),
  //       subTitle: tr('pleaseRead'),
  //       description: tr('dataPrivacy'),
  //       textButton: tr('Accept'),
  //       textButton2: tr('Cancel'),
  //       imageColor: AppColors.triadicBlue,
  //       onPressed: () {
  //         // NavigationService.popUntil(Get.context!, "Pass your data here");
  //         Navigator.pop(Get.context!, true);
  //       });
  // }

  // static Future showApplicationInReviewDialog() async {
  //   return await DialogWidget.showCustomDialog(
  //       context: Get.context!,
  //       title: tr('applicationStatus'),
  //       description: tr('applicationStatusReponse'),
  //       textButton: tr('Close'),
  //       imageColor: AppColors.triadicBlue,
  //       onPressed: () {
  //         // NavigationService.popUntil(Get.context!, "Pass your data here");
  //         Navigator.pop(Get.context!, true);
  //       });
  // }

}
