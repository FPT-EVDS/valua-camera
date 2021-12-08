import 'package:evds_staff/routes/app_pages.dart';
import 'package:evds_staff/widgets/carousel_with_indicator.dart';
import 'package:evds_staff/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PositionScreen extends StatelessWidget {
  const PositionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Confirm positions"),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RoundButton(
          onPressed: () {
            Get.offAllNamed(AppRoutes.createViolation);
          },
          width: double.infinity,
          label: "Confirm",
          height: 48,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CarouselWithIndicator(itemList: [
                      'https://suachuamaytinhtannoigiare.com/kcfinder/upload/images/maxresdefault%282%29.jpg',
                      'https://lapdatcameragiare.vn/wp-content/uploads/bfi_thumb/camera-quan-sat-phong-thi1-38880ywfiz0p8w24w534sq.jpg'
                    ]),
                    const SizedBox(height: 15),
                    const Text(
                      "Please make sure these positions are correct",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1634896941598-b6b500a502a7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=756&q=80"),
                          ),
                          title: const Text(
                            "SE142451",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            "Aaron Smith",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          trailing: Text(
                            "Pos 1",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
