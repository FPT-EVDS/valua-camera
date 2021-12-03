import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShiftCard extends StatelessWidget {
  final Widget thumbnail;
  final DateTime date;
  final DateTime beginTime;
  final DateTime endTime;
  final String location;

  const ShiftCard(
      {Key? key,
      required this.thumbnail,
      required this.date,
      required this.beginTime,
      required this.endTime,
      required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {},
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Center(child: thumbnail),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CommunityMaterialIcons.calendar_range,
                          color: Colors.grey.shade700,
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
                        ),
                        const SizedBox(width: 10),
                        Text(DateFormat("HH:mm").format(beginTime) +
                            " - " +
                            DateFormat("HH:mm").format(endTime))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          CommunityMaterialIcons.map_marker_outline,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(width: 10),
                        Text(location)
                      ],
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
