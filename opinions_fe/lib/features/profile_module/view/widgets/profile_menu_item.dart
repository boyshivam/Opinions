import "package:flutter/material.dart";
import "package:opinions/features/profile_module/models/profile_menu_item_model.dart";

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({super.key, required this.item});

  final ProfileMenuItemModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25
          ),
          decoration: BoxDecoration(
            color: Colors.black26
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(item.icon, size: 25),
              Text(item.text, style: TextStyle(fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}
