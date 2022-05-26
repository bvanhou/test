import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/widgets/custom_tile_component.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';

class SettingsSectionComponent extends StatelessWidget {
  const SettingsSectionComponent({
    required this.headerIcon,
    required this.headerTitle,
    this.headerTrailing,
    required this.tileList,
    Key? key,
  }) : super(key: key);

  final IconData headerIcon;
  final String headerTitle;
  final Widget? headerTrailing;
  final List<CustomTileComponent> tileList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      color: Colors.transparent,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: Sizes.vPaddingTiny(context)),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Material(
            child: ListTile(
              tileColor: Theme.of(context).scaffoldBackgroundColor,
              horizontalTitleGap: 0,
              // leading: Icon(
              //   headerIcon,
              // ),
              title: CustomText.h6(
                context,
                headerTitle,
                maxLines: 1,
                weight: FontStyles.fontWeightBold,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: headerTrailing,
            ),
          ),
          ...tileList,
        ],
      ),
    );
  }
}
