import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/app/modules/dashboard/models/dashboard_model.dart';
import 'package:shopping/app/modules/dashboard/repository/dashboard_repository.dart';
import '../../../models/product_model.dart';
import '../../../routes/app_pages.dart'; 

class DashboardController extends GetxController {
  final DashboardRepository dashboardRepository;
  DashboardController({required this.dashboardRepository});

  RxBool isLoading = true.obs;
  Rx<DashboardModel> dashboardModel = DashboardModel.initial().obs;
  final TextEditingController keyword = TextEditingController();

  Rx<Duration> saleCountdown = Duration.zero.obs;
  Timer? _saleTimer;

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)} : ${twoDigits(duration.inMinutes.remainder(60))} : ${twoDigits(duration.inSeconds.remainder(60))}";
  }

  String calculateDiscountPercentage(String? priceStr, String? discountedStr) {
    try {
      final price = double.tryParse(priceStr?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '');
      final discounted = double.tryParse(discountedStr?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '');

      if (price != null && discounted != null && price > 0 && discounted < price) {
        final percent = ((price - discounted) / price * 100).round();
        return '-$percent%';
      }
    } catch (e) {
      print('Error calculating discount: $e');
    }
    return '';
  }

  // Thêm biến để quản lý carousel index
  final currentCarouselIndex = 0.obs;

  // Phương thức cập nhật carousel index
  void updateCarouselIndex(int index) {
    currentCarouselIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onClose() {
    _saleTimer?.cancel();
    keyword.dispose();
    super.onClose();
  }

  void loadData() async {
    isLoading.value = true;
    try {
      final response = await dashboardRepository.loadData(
        DashboardModel(userId: '233', act: 'home'),
      );

      if (response != null && response.status == true && response.data != null) {
        dashboardModel.value = DashboardModel.fromJson(response.data!);
        int saleSecondsLeft = dashboardModel.value.saleRemainingSeconds ?? 3600;
        _startSaleCountdown(Duration(seconds: saleSecondsLeft));
        
        print('Dashboard loaded successfully');
        print('Products sale count: ${dashboardModel.value.arrayProductsSale?.length}');
        print('Products home count: ${dashboardModel.value.arrayProductsHome?.length}');
      } else {
        print('Lỗi load dashboard: ${response?.message}');
        dashboardModel.value = DashboardModel.initial();
        _startSaleCountdown(Duration.zero);
      }
    } catch (e) {
      print('Exception loading dashboard: $e');
      dashboardModel.value = DashboardModel.initial();
      _startSaleCountdown(Duration.zero);
    }

    isLoading.value = false;
  }

  void _startSaleCountdown(Duration duration) {
    _saleTimer?.cancel();
    saleCountdown.value = duration;

    if (duration.inSeconds <= 0) return;

    _saleTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (saleCountdown.value.inSeconds > 0) {
        saleCountdown.value = saleCountdown.value - const Duration(seconds: 1);
      } else {
        timer.cancel();
      }
    });
  }

  void onSearchSubmitted(String value) {
    if (value.trim().isNotEmpty) {
      Get.toNamed(Routes.SEARCH_PRODUCT, arguments: {'keyword': value});
    }
  }

  List<ProductModel> get productSales {
    return dashboardModel.value.arrayProductsSale
            ?.map((e) => ProductModel.fromJson(e))
            .toList() ?? [];
  }

  List<ProductModel> get productHome {
    return dashboardModel.value.arrayProductsHome
            ?.map((e) => ProductModel.fromJson(e))
            .toList() ?? [];
  }

  List<ProductModel> get productAll {
    return dashboardModel.value.arrayProductsAll
            ?.map((e) => ProductModel.fromJson(e))
            .toList() ?? [];
  }

  // Xử lý khi nhấn vào danh mục
  void onCategoryTap({required String? id, required String name}) {
    if (id != null) {
      Get.toNamed(Routes.LIST_CATEGORY, arguments: {'catId': id, 'name': name});
    } else {
      Get.snackbar('Lỗi', 'Không tìm thấy ID danh mục');
    }
  }

  // Refresh data
  void refreshData() {
    loadData();
  }
}