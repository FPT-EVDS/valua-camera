import 'package:flutter/material.dart';
import 'package:valua_camera/widgets/card_button.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:valua_camera/screens/regulation/regulation.dart';
import 'package:get/get.dart';
import 'package:valua_camera/widgets/violator_list_title.dart';

class ViolatorScreen extends StatelessWidget {
  const ViolatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CommunityMaterialIcons.chevron_left),
            onPressed: () {
              Get.off(RegulationScreen());
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                CommunityMaterialIcons.magnify,
                color: Colors.black,
              ),
            ),
          ],
          centerTitle: true,
          title: const Text(
            'Select violator',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ViolatorListTile(
                position: 1,
                imageUrl: "https://picsum.photos/200",
                subtitle: "Nguyen Huu Huy",
                title: "SE140380",
              ),
              ViolatorListTile(
                position: 2,
                imageUrl: "https://picsum.photos/200",
                subtitle: "Tran Cam Long",
                title: "SE140312",
              ),
              ViolatorListTile(
                position: 3,
                imageUrl: "https://picsum.photos/200",
                subtitle: "Ngo Tan Duc",
                title: "SE140360",
              ),
              ViolatorListTile(
                position: 4,
                imageUrl: "https://picsum.photos/200",
                subtitle: "Nguyen Thi Kim Hang",
                title: "SE140388",
              ),
              ViolatorListTile(
                position: 5,
                imageUrl: "https://picsum.photos/200",
                subtitle: "Hua Vinh Khang",
                title: "SE140399",
              ),
              ViolatorListTile(
                position: 6,
                imageUrl: "https://picsum.photos/200",
                subtitle: "Ngo Vinh Khang",
                title: "SE140209",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
