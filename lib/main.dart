import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/providers/auth_provider.dart';
import 'package:valua_camera/routes/routes.dart';
import 'package:valua_camera/services/auth_service.dart';
import 'package:valua_camera/theme/theme.dart';

void main() async {
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/font/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  await Get.putAsync(() => GetStorage.init(AppConstant.storageKey));
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.lazyPut(() => AuthProvider());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GetStorage _storage = GetStorage(AppConstant.storageKey);
    return GetMaterialApp(
      title: 'Valua Camera',
      theme: AppThemes(context).defaultTheme,
      defaultTransition: Transition.fade,
      initialBinding: AppBinding(),
      initialRoute: _storage.read("access_token") != null
          ? AppRoutes.main
          : AppRoutes.regulation,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
    );
  }
}
