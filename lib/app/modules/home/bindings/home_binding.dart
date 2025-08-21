import 'package:get/get.dart';
// import 'package:shopping/app/modules/cart/controllers/cart_controller.dart';
// import 'package:shopping/app/modules/cart/provider/cart_provider.dart';
// import 'package:shopping/app/modules/cart/repository/cart_repository.dart';
import 'package:shopping/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:shopping/app/modules/dashboard/provider/dashboard_provider.dart';
import 'package:shopping/app/modules/dashboard/repository/dashboard_repository.dart';
// import 'package:shopping/app/modules/account/controllers/account_controller.dart';
// import 'package:shopping/app/modules/account/provider/account_provider.dart';
// import 'package:shopping/app/modules/account/repository/account_repository.dart';
// import 'package:shopping/app/modules/card/controllers/card_controller.dart';
// import 'package:shopping/app/modules/card/provider/card_provider.dart';
// import 'package:shopping/app/modules/card/repository/card_repository.dart';
// import 'package:shopping/app/modules/dashboard/controllers/dashboard_controller.dart';
// import 'package:shopping/app/modules/dashboard/provider/dashboard_provider.dart';
// import 'package:shopping/app/modules/dashboard/repository/dashboard_repository.dart';
import 'package:shopping/app/modules/home/controllers/home_controller.dart';
import 'package:shopping/app/modules/home/provider/home_provider.dart';
import 'package:shopping/app/modules/home/repository/home_repository.dart';
// import 'package:shopping/app/modules/news/controllers/news_controller.dart';
// import 'package:shopping/app/modules/news/provider/news_provider.dart';
// import 'package:shopping/app/modules/news/repository/news_repository.dart';
// import 'package:shopping/app/modules/notification/controllers/notification_controller.dart';
// import 'package:shopping/app/modules/notification/provider/notification_provider.dart';
// import 'package:shopping/app/modules/notification/repository/notification_repository.dart';
import 'package:shopping/app/services/http_provider.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeProvider(http: Get.find<HttpProvider>()));
    Get.lazyPut(() => HomeRepository(homeProvider: Get.find<HomeProvider>()),
        fenix: true);
    Get.lazyPut(
        () => HomeController(homeRepository: Get.find<HomeRepository>()),
        fenix: true);
    // Get.lazyPut(() => AccountProvider(http: Get.find<HttpProvider>()));
    // Get.lazyPut(
    //     () => AccountRepository(accountProvider: Get.find<AccountProvider>()),
    //     fenix: true);
    // Get.lazyPut(
    //     () =>
    //         AccountController(accountRepository: Get.find<AccountRepository>()),
    //     fenix: true);
    //  Get.lazyPut(() => CartProvider(http: Get.find<HttpProvider>()));
    //  Get.lazyPut(() => CartRepository(cartProvider: Get.find<CartProvider>()),
    //      fenix: true);
    //  Get.lazyPut(
    //      () => CartController(cartRepository: Get.find<CartRepository>()),
    //      fenix: true);
    Get.lazyPut(() => DashboardProvider(http: Get.find<HttpProvider>()));
     Get.lazyPut(
         () => DashboardRepository(
             dashboardProvider: Get.find<DashboardProvider>()),
         fenix: true);
     Get.lazyPut(
         () => DashboardController(
             dashboardRepository: Get.find<DashboardRepository>()),
         fenix: true);
    // Get.lazyPut(() => NewsProvider(http: Get.find<HttpProvider>()));
    // Get.lazyPut(() => NewsRepository(newsProvider: Get.find<NewsProvider>()),
    //     fenix: true);
    // Get.lazyPut(
    //     () => NewsController(newsRepository: Get.find<NewsRepository>()),
    //     fenix: true);
    // Get.lazyPut(() => NotificationProvider(http: Get.find<HttpProvider>()));
    // Get.lazyPut(
    //     () => NotificationRepository(
    //         notificationProvider: Get.find<NotificationProvider>()),
    //     fenix: true);
    // Get.lazyPut(
    //     () => NotificationController(
    //         notificationRepository: Get.find<NotificationRepository>()),
    //     fenix: true);
  }
}
