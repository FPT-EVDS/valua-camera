import 'package:community_material_icon/community_material_icon.dart';
import 'package:evds_staff/routes/app_pages.dart';
import 'package:evds_staff/screens/profile/profile_controller.dart';
import 'package:evds_staff/widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const double profileHeight = 120;
  static const double coverHeight = 160;

  @override
  Widget build(BuildContext context) {
    const top = coverHeight - profileHeight / 2 - 20;
    const bottom = profileHeight / 2;
    final _controller = Get.find<ProfileController>();

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
                        children: [
                          CachedCircleAvatar(
                            imageUrl:
                                _controller.currentUser.imageUrl.toString(),
                            radius: 45,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _controller.currentUser.fullName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                  _controller.handleMenuTap(index);
                },
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  child: Icon(
                    _controller.menuData[index].icon,
                  ),
                ),
                title: Text(_controller.menuData[index].title),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 25),
            itemCount: _controller.menuData.length,
          ),
        )
      ],
    );
  }
}
