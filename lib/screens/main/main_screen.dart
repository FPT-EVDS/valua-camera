import 'package:animations/animations.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:evds_staff/screens/evidence/evidence.dart';
import 'package:evds_staff/screens/home/home.dart';
import 'package:evds_staff/screens/main/main_controller.dart';
import 'package:evds_staff/screens/notification/notification.dart';
import 'package:evds_staff/screens/profile/profile.dart';
import 'package:evds_staff/screens/violation/violation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Obx(
          () => controller.tabIndex.value == 0
              ? Image.asset(
                  "assets/icons/evds_logo_right.png",
                  height: 96,
                  width: 96,
                )
              : Text(
                  controller.appBarTitle.value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                FadeThroughTransition(
              child: child,
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
            ),
            child: IndexedStack(
              key: ValueKey<int>(controller.tabIndex.value),
              index: controller.tabIndex.value,
              children: const [
                HomeScreen(),
                ViolationScreen(),
                EvidenceScreen(),
                NotificationScreen(),
                ProfileScreen(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex.value,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CommunityMaterialIcons.home_outline),
              activeIcon: Icon(CommunityMaterialIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CommunityMaterialIcons.alarm_light_outline),
              activeIcon: Icon(CommunityMaterialIcons.alarm_light),
              label: 'Violation',
            ),
            BottomNavigationBarItem(
              icon: Icon(CommunityMaterialIcons.archive_outline),
              activeIcon: Icon(CommunityMaterialIcons.archive),
              label: 'Evidence',
            ),
            BottomNavigationBarItem(
              icon: Icon(CommunityMaterialIcons.bell_outline),
              activeIcon: Icon(CommunityMaterialIcons.bell),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(CommunityMaterialIcons.account_circle_outline),
              activeIcon: Icon(CommunityMaterialIcons.account_circle),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
