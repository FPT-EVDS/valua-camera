import 'package:evds_examinee/widgets/avatar_with_title.dart';
import 'package:evds_examinee/widgets/rich_text_item.dart';
import 'package:flutter/material.dart';

class DetailShiftScreen extends StatelessWidget {
  const DetailShiftScreen({Key? key}) : super(key: key);
  static const itemLength = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "SU21_PRF192_10W",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  RichTextItem(title: "Date: ", content: "23/08/2021"),
                  RichTextItem(title: "Time: ", content: "14:15 - 15:45"),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  RichTextItem(title: "Room: ", content: "201"),
                  RichTextItem(title: "Violation count: ", content: "0"),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  RichTextItem(
                    title: "Shift Manager: ",
                    content: "Johnny Walker",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Examinees list",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 28),
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // FIXME: change to dynamic length here
                    if (itemLength > 4 && index == 3) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Text(
                              "+${itemLength - 3}",
                              style: TextStyle(
                                letterSpacing: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const AvatarWithTitle(
                      radius: 32,
                      imageUrl:
                          "https://images.unsplash.com/photo-1628890923662-2cb23c2e0cfe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                      title: "Nico Marks",
                      subtitle: "SE123456",
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
