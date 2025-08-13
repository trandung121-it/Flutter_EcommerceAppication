import 'package:get/get.dart';

import '../../../services/http_provider.dart';
import '../controllers/dashboard_controller.dart';
import '../provider/dashboard_provider.dart';
import '../repository/dashboard_repository.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardProvider(http: Get.find<HttpProvider>()));
    Get.lazyPut(() => DashboardRepository(
        dashboardProvider: Get.find<DashboardProvider>()));
    Get.put(DashboardController(
      dashboardRepository: Get.find<DashboardRepository>(),
    ));
  }
}