import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/global_binding/app_bindings.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Init storage
  runApp(
    GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: Get.defaultDialogTransitionDuration,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      theme: ThemeData(fontFamily: "Montserrat"),
    ),
  );
}
