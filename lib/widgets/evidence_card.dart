import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EvidenceCard extends StatelessWidget {
  final void Function()? onTap;
  final Widget thumbnail;
  final DateTime date;
  final DateTime capturedAt;
  final DateTime lastUpdatedAt;
  final int status;

  const EvidenceCard({
    Key? key,
    this.onTap,
    required this.thumbnail,
    required this.date,
    required this.capturedAt,
    required this.lastUpdatedAt,
    required this.status,
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
                    status != 0
                        ? Row(
                            children: [
                              status == 1
                                  ? Icon(
                                      CommunityMaterialIcons.check_bold,
                                      color: Colors.green.shade700,
                                      size: 18,
                                    )
                                  : Icon(
                                      CommunityMaterialIcons.close,
                                      color: Colors.red.shade700,
                                      size: 18,
                                    ),
                              const SizedBox(width: 10),
                              Text(DateFormat("HH:mm dd/MM/yyyy")
                                  .format(lastUpdatedAt))
                            ],
                          )
                        : SizedBox(
                            width: double.infinity,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                if (onTap != null) {
                                  onTap!();
                                }
                              },
                              child: const Text("Evaluate"),
                            ),
                          ),
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
