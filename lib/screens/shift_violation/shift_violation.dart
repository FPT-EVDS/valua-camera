import 'package:evds_staff/routes/app_pages.dart';
import 'package:evds_staff/widgets/shift_violation_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShiftViolationScreen extends StatelessWidget {
  const ShiftViolationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(Get.arguments.toString()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: 2,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ShiftViolationCard(
              onTap: () => Get.toNamed(AppRoutes.detailViolation),
              thumbnail: Image.network(
                "https://suachuamaytinhtannoigiare.com/kcfinder/upload/images/maxresdefault%282%29.jpg",
              ),
              date: DateTime.now(),
              capturedAt: DateTime.now(),
              violator: "SE142312",
            ),
          ),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 5),
        ),
      ),
    );
  }
}
