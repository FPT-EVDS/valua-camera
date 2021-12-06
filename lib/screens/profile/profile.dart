import 'package:community_material_icon/community_material_icon.dart';
import 'package:evds_staff/routes/app_pages.dart';
import 'package:evds_staff/widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItem {
  final IconData icon;
  final String title;
  final String to;

  MenuItem({
    required this.icon,
    required this.title,
    required this.to,
  });
}

final List<MenuItem> _menuData = [
  MenuItem(
    icon: CommunityMaterialIcons.lock_reset,
    title: "Reset password",
    to: AppRoutes.resetPassword,
  ),
  MenuItem(
    icon: CommunityMaterialIcons.cog,
    title: "Settings",
    to: "#",
  ),
  MenuItem(
    icon: CommunityMaterialIcons.file_document,
    title: "Terms & Policies",
    to: "#",
  ),
  MenuItem(
    icon: CommunityMaterialIcons.logout_variant,
    title: "Logout",
    to: AppRoutes.login,
  ),
];

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const double profileHeight = 120;
  static const double coverHeight = 160;

  @override
  Widget build(BuildContext context) {
    const top = coverHeight - profileHeight / 2 - 20;
    const bottom = profileHeight / 2;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: bottom),
              child: Image.asset(
                "assets/images/background.png",
                height: coverHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: top,
              child: Stack(
                children: [
                  Card(
                    elevation: 2,
                    child: SizedBox(
                      width: 180,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CachedCircleAvatar(
                            imageUrl:
                                "https://images.unsplash.com/photo-1514846326710-096e4a8035e0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
                            radius: 45,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "John Smith",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          icon: const Icon(
                            CommunityMaterialIcons.square_edit_outline,
                            size: 20,
                          ),
                          color: Theme.of(context).primaryColor,
                          splashColor: Colors.blue.withAlpha(30),
                          onPressed: () {
                            Get.toNamed(AppRoutes.detailProfile);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            itemBuilder: (context, index) => Card(
              elevation: 2,
              child: ListTile(
                onTap: () {
                  if (_menuData[index].to == AppRoutes.login) {
                    // do something with token
                    Get.offAllNamed(_menuData[index].to);
                  }
                  // FIXME: Remove if when settings and term is initialize
                  if (_menuData[index].to == AppRoutes.resetPassword) {
                    Get.toNamed(_menuData[index].to);
                  }
                },
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  child: Icon(
                    _menuData[index].icon,
                  ),
                ),
                title: Text(_menuData[index].title),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 25),
            itemCount: _menuData.length,
          ),
        )
      ],
    );
  }
}
