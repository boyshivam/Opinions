import "package:flutter/material.dart";
import 'package:opinions/features/profile_module/models/profile_menu_item_model.dart';
import 'package:opinions/router/routes.dart';

const List<ProfileMenuItemModel> profileMenuItemsData = [
  ProfileMenuItemModel(icon: Icons.account_circle, text: "Account details", navigationRoute: ""),
  ProfileMenuItemModel(icon: Icons.receipt_long, text: "Orders", navigationRoute: ""),
  ProfileMenuItemModel(icon: Icons.settings, text: "Settings", navigationRoute: ""),
  ProfileMenuItemModel(icon: Icons.logout, text: "Logout", navigationRoute: AppRoutes.loginScreen),

];