import "package:flutter/material.dart";
import "package:opinions/features/profile_module/models/profile_menu_item_model.dart";
import "package:opinions/features/profile_module/view/widgets/profile_menu_item.dart";

class ProfileMenuItemsViewer extends StatelessWidget {
  const ProfileMenuItemsViewer({
    super.key,
    required this.parentHeight,
    required this.itemsList,
  });

  final double parentHeight;
  final List<ProfileMenuItemModel> itemsList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: parentHeight,
      child: ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (context, index) {
          return ProfileMenuItem(item: itemsList[index]);
        },
      ),
    );
  }
}
