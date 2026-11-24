import 'package:flutter/material.dart';
import 'package:opinions/features/profile_module/data/profile_menu_items_data.dart';
import 'package:opinions/features/profile_module/view/widgets/profile_menu_items_viewer.dart';
import 'package:opinions/features/profile_module/view/widgets/profile_top_section.dart';

class ProfileDashboardScreen extends StatefulWidget {
  const ProfileDashboardScreen({super.key});

  @override
  State<ProfileDashboardScreen> createState() => _ProfileDashboardScreenState();
}

class _ProfileDashboardScreenState extends State<ProfileDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;

          return SingleChildScrollView(
            child: Column(
              children: [
                ProfileTopSection(),
                ProfileMenuItemsViewer(
                  parentHeight: maxHeight,
                  itemsList: profileMenuItemsData,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
