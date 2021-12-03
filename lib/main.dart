import 'package:evds_staff/routes/routes.dart';
import 'package:evds_staff/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/font/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EVDS Staff',
      theme: AppThemes(context).defaultTheme,
      defaultTransition: Transition.fade,
      initialRoute: AppRoutes.login,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
    );
  }
}
