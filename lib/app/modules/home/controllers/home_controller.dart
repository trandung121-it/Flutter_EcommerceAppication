import 'package:get/get.dart';
import 'package:shopping/app/modules/home/repository/home_repository.dart';


import '../../../routes/app_pages.dart';
import '../../../services/global_service.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepository;
  var tabIndex = 0;
  var params;
  final globalService = Get.find<GlobalService>();

  HomeController({required this.homeRepository});

  @override
  void onInit() async {
    // TODO: implement onInit
    params = Get.arguments;
    // globalService.notificationHome.stream.listen((event) async {
    //   if (event.isNotEmpty) {
    //     var appbarController = Get.find<AppbarCustomController>();
    //     await Future.delayed(Duration(milliseconds: 700), () {
    //       appbarController.readTotalNotification();
    //     });
    //   }
    // });
    super.onInit();
  }

  void changeTabIndex(int index, {String? listSeries}) {
    tabIndex = index;
    update();
  }

  @override
  void onReady() {
    if (params != null && params['id'] != null) {
      Get.toNamed(Routes.INFORMATION_ORDER, arguments: params['id']);
    }
    super.onReady();
  }
}
