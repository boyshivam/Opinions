import "package:flutter/material.dart";
import "package:opinions/core/themes/app_colors.dart";

class ProfileTopSection extends StatelessWidget {
  const ProfileTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(25, MediaQuery.of(context).padding.top + 15, 25, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:
        [AppColors.blueShade3, AppColors.blueShade1],
        begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Column(
        children: [
          Text("Hi, user", style: TextStyle(
            fontSize: 27
          ),),

        ],
      ),
    );
  }
}
