import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShiftViolationCard extends StatelessWidget {
  final Function()? onTap;
  final Widget thumbnail;
  final DateTime date;
  final DateTime capturedAt;
  final String violator;

  const ShiftViolationCard({
    Key? key,
    this.onTap,
    required this.thumbnail,
    required this.date,
    required this.capturedAt,
    required this.violator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Center(
                  child: thumbnail,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CommunityMaterialIcons.calendar_range,
                          color: Colors.grey.shade700,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(DateFormat("dd/MM/yyyy").format(date)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          CommunityMaterialIcons.clock_outline,
                          color: Colors.grey.shade700,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(DateFormat("HH:mm").format(capturedAt))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          CommunityMaterialIcons.account_cancel_outline,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(violator)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
