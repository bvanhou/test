import 'package:deliverzler/auth/repos/user_repo.dart';
import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/widgets/cached_network_image_circular.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserInfoComponent extends ConsumerWidget {
  const UserInfoComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _userModel = ref.watch(userRepoProvider).userModel;

    return Row(
      children: <Widget>[
        CachedNetworkImageCircular(
          imageUrl: _userModel!.image,
          radius: Sizes.userImageMediumRadius(context),
        ),
        SizedBox(
          width: Sizes.hMarginMedium(context),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomText.h3(
                context,
                _userModel.username.isEmpty
                    ? 'User${_userModel.uId.substring(0, 6)}'
                    : _userModel.username,
                weight: FontStyles.fontWeightBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              CustomText.h5(
                context,
                _userModel.email,
                color: Theme.of(context).textTheme.headline5!.color,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        PlatformIconButton(
          onPressed: () {
            NavigationService.push(
              context,
              isNamed: true,
              page: RoutePaths.settingsProfile,
            );
          },
          icon: Icon(
            Icons.edit_outlined,
            size: Sizes.roundedButtonDefaultMediumRadius(context),
            color: AppColors.primaryColor,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.appBarMenuButtonRadius(context) / 2,
          ),
          material: (_, __) {
            return MaterialIconButtonData(
              constraints: const BoxConstraints(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            );
          },
          cupertino: (_, __) {
            return CupertinoIconButtonData(
              alignment: Alignment.center,
            );
          },
        )
      ],
    );
  }
}
