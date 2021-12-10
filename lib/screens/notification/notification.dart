import 'package:valua_staff/screens/notification/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationController controller =
        Get.find<NotificationController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => controller.notifications.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/notify.svg",
                      height: 120,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "No notifications yet!",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: Text(
                        "We will notify you once we have something for you",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.notifications),
                  ),
                  title: const Text("Notification title"),
                  subtitle: const Text("Lorem ipsum is something"),
                ),
                itemCount: controller.notifications.length,
              ),
      ),
    );
  }
}
