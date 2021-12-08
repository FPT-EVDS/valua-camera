import 'package:evds_staff/routes/app_pages.dart';
import 'package:evds_staff/widgets/carousel_with_indicator.dart';
import 'package:evds_staff/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailEvidenceScreen extends StatelessWidget {
  const DetailEvidenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Evidence detail"),
        centerTitle: true,
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
                      "Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "\u2022 Recorded at : ${DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now())}"),
                          const SizedBox(height: 10),
                          const Text('\u2022 Evaluated at : N/A'),
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              text: "\u2022 Status: ",
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text: "Pending",
                                  style:
                                      TextStyle(color: Colors.amber.shade700),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Violators",
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
                    const SizedBox(height: 30),
                    RoundButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            titlePadding: const EdgeInsets.all(16.0),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            title: const Text("Confirm evidence ?"),
                            content: const Text(
                              "This action can’t be revert",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.offAllNamed(AppRoutes.position);
                                },
                                child: const Text("Confirm"),
                              ),
                            ],
                          ),
                        );
                      },
                      width: double.infinity,
                      label: "Confirm evidence",
                      height: 48,
                    ),
                    const SizedBox(height: 15),
                    RoundButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Reject evidence ?"),
                            content: const Text(
                              "This action can’t be revert",
                            ),
                            titlePadding: const EdgeInsets.all(16.0),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Confirm"),
                              ),
                            ],
                          ),
                        );
                      },
                      width: double.infinity,
                      color: Colors.red.shade700,
                      label: "Reject evidence",
                      height: 48,
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
