import 'package:community_material_icon/community_material_icon.dart';
import 'package:evds_examinee/routes/app_pages.dart';
import 'package:evds_examinee/screens/shift/shift_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ShiftScreen extends StatelessWidget {
  const ShiftScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<ShiftController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Assigned shift"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(CommunityMaterialIcons.calendar),
            tooltip: 'Choose date',
            onPressed: () {
              _controller.handleDatePicker(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => TableCalendar(
                focusedDay: _controller.currentFocusedDay.value,
                firstDay: DateTime.utc(2021, 1, 1),
                lastDay: DateTime.now(),
                calendarFormat: _controller.calendarFormat,
                availableCalendarFormats: const {CalendarFormat.week: 'Week'},
                headerVisible: false,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: _controller.handleSelectDate,
                selectedDayPredicate: _controller.selectedDatePredicate,
                onPageChanged: _controller.handleChangePage,
                calendarStyle: CalendarStyle(
                  defaultDecoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  weekendDecoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.detailShift);
                    },
                    title: Text(
                      "14:15 - 15:45",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "SU21_PRF192_10W - Room: 101",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
