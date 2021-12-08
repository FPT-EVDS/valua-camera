import 'package:evds_staff/screens/evidence/evidence_controller.dart';
import 'package:evds_staff/widgets/evidence_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EvidenceScreen extends StatelessWidget {
  const EvidenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<EvidenceController>();
    return Column(
      children: [
        Center(
          child: Obx(
            () => CupertinoSegmentedControl(
              groupValue: _controller.currentSelection.value,
              children: {
                0: buildSegment("Pending"),
                1: buildSegment("Approved"),
                2: buildSegment("Rejected"),
              },
              onValueChanged: _controller.handleChangeSegment,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: EvidenceCard(
                thumbnail: Image.network(
                  "https://suachuamaytinhtannoigiare.com/kcfinder/upload/images/maxresdefault%282%29.jpg",
                ),
                date: DateTime.now(),
                capturedAt: DateTime.now(),
                lastUpdatedAt: DateTime.now(),
                status: 0,
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemCount: 2,
          ),
        )
      ],
    );
  }

  Widget buildSegment(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }
}
