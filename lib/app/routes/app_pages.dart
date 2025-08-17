import 'package:get/get.dart';

import 'package:shopping/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:shopping/app/modules/dashboard/views/dashboard_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
   
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    
  ];
}
