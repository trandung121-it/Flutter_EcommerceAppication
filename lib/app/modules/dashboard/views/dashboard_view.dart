import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopping/app/core/alert.dart';
import 'package:shopping/app/global_widgets/text_field_search.dart';
import '../controllers/dashboard_controller.dart';
import 'package:shopping/app/routes/app_pages.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key});
  final RxInt currentCarouselIndex = 0.obs;
  final CarouselController carouselController = CarouselController();

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)} : ${twoDigits(duration.inMinutes.remainder(60))} : ${twoDigits(duration.inSeconds.remainder(60))}";
  }

  Widget _buildImage(String? imageUrl,
      {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: const Icon(Icons.image_not_supported),
      );
    }

    return Image.network(
      'https://api.vuagaovn.com$imageUrl',
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: const Icon(Icons.error_outline),
      ),
      loadingBuilder: (_, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final model = controller.dashboardModel.value;

        if (model.bannerHome == null &&
            model.arrayCategoryProducts == null &&
            model.arrayArticlesNew == null) {
          return const Center(child: Text("Không có dữ liệu để hiển thị"));
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (model.bannerHome?.isNotEmpty ?? false)
                      _buildImage(model.bannerHome!.first, fit: BoxFit.cover),

                    // Tìm kiếm sản phẩm với TextFieldSearch, dùng controller.keyword của DashboardController để giữ trạng thái
                    Positioned(
  left: 16,
  right: 16,
  bottom: 50,
  child: Material(
    elevation: 4,
    borderRadius: BorderRadius.circular(30),
    child: InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        Get.toNamed(Routes.SEARCH_PRODUCT); // Chuyển sang trang tìm kiếm
      },
      child: Container(
        height: 45.0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              'Tìm sản phẩm...',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
          ],
        ),
      ),
    ),
  ),
)

                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Danh mục sản phẩm
                    if (model.arrayCategoryProducts?.isNotEmpty ?? false) ...[
                      const Text('Danh mục sản phẩm',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.arrayCategoryProducts!.length,
                          itemBuilder: (_, index) {
                            final item = model.arrayCategoryProducts![index];
                            final image = item['image']?.toString();
                            final name = item['name']?.toString() ?? 'No name';
                            final id = item['id']?.toString();

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: InkWell(
                                onTap: () => controller.onCategoryTap(id: id, name: name),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: _buildImage(image,
                                          width: 70, height: 70),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: 80,
                                      child: Text(name,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    // Quảng cáo sản phẩm mới
                    if (model.arrayArticlesNew?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Quảng cáo sản phẩm mới',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CarouselSlider.builder(
                      itemCount: model.arrayArticlesNew!.length,
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 160,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          controller.updateCarouselIndex(index);
                        },
                      ),
                      itemBuilder: (context, index, realIdx) {
                        final item = model.arrayArticlesNew![index];
                        final productId = item['id']?.toString();
                        return GestureDetector(
                          onTap: () {
                            if (productId != null) {
                              Get.toNamed(Routes.PRODUCTS_DETAIL,
                                  arguments: {'productId': productId});
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _buildImage(item['image']),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(model.arrayArticlesNew!.length, (index) {
                          final isActive = controller.currentCarouselIndex.value == index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isActive ? 36 : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFF9BC523)
                                  : const Color(0xFF9BC523).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        }),
                      )),
                    ],



                    // Đếm ngược sale
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sale',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Obx(() => Text(
                              controller.formatDuration(controller.saleCountdown.value),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            )),
                        TextButton(
                                onPressed: () {
                                  Get.toNamed('/list_category', arguments: {
                                    'catId': '-1',
                                    'name': 'Sản phẩm Sale',
                                  });
                                },
                                child: const Text('Xem tất cả >',
                                    style: TextStyle(color: Colors.red)),
                    ),
                      ],
                    ),

                    // Sản phẩm Sale
                    if (model.arrayProductsSale?.isNotEmpty ?? false)
                      SizedBox(
                        height: 270,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.arrayProductsSale!.length,
                          itemBuilder: (_, index) {
                            final p = model.arrayProductsSale![index];
                            return SaleProductCard(product: p);
                          },
                        ),
                      ),

                    // Sản phẩm gợi ý
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sản phẩm bạn có thể biết',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.LIST_CATEGORY, arguments: {
                                'catId': '-2',
                                'name': 'Sản phẩm bạn có thể biết',
                              });
                            },
                            child: const Text('Xem tất cả >',
                                style: TextStyle(color: Colors.red)),
                          ),
                      ],
                    ),

                    if (model.arrayProductsHome?.isNotEmpty ?? false)
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.arrayProductsHome!.length,
                          itemBuilder: (_, index) {
                            final p = model.arrayProductsHome![index];
                            return _buildProductCard(p, showSold: true);
                          },
                        ),
                      ),

                    // Tất cả sản phẩm
                    const SizedBox(height: 20),
                    const Text('Tất cả sản phẩm',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    if (model.arrayProductsAll?.isNotEmpty ?? false)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: model.arrayProductsAll!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (_, index) {
                          final p = model.arrayProductsAll![index];
                          return AllProductCard(product: p);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProductCard(Map product, {bool showSold = false}) {
  return InkWell(
    onTap: () {
      final productId = product['id']?.toString();
      if (productId != null) {
        Get.toNamed(Routes.PRODUCTS_DETAIL,
            arguments: {'productId': productId});
      }
    },
    child: Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            _buildImage(product['image']?.toString(), height: 100),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: 36, // đảm bảo tên sản phẩm luôn chiếm 2 dòng
                child: Text(
                  product['name']?.toString() ?? 'No name',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF9BC523)),
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Giá bán
            SizedBox(
              height: 20,
              child: Text(
                '${product['price'] ?? 0} Đ',
                style: const TextStyle(color: Colors.red),
              ),
            ),
            // Giá gốc (nếu có)
            SizedBox(
              height: 18,
              child: product['original_price'] != null
                  ? Text(
                      '${product['original_price']} Đ',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            
          ],
        ),
      ),
    ),
  );
}
}

class AllProductCard extends StatelessWidget {
  final Map product;

  const AllProductCard({Key? key, required this.product}) : super(key: key);

  Widget _buildImage(String? imageUrl, {double? height}) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        height: height,
        color: Colors.grey[200],
        child: const Icon(Icons.image_not_supported),
      );
    }

    return Image.network(
      'https://api.vuagaovn.com$imageUrl',
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        height: height,
        color: Colors.grey[200],
        child: const Icon(Icons.error_outline),
      ),
      loadingBuilder: (_, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: height,
          color: Colors.grey[200],
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productId = product['id']?.toString();
    return InkWell(
      onTap: () {
        if (productId != null) {
          Get.toNamed(Routes.PRODUCTS_DETAIL, arguments: {'productId': productId});
        }
      },
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(product['image']?.toString(), height: 120),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
            
                child: Text(
                  product['name']?.toString() ?? 'No name',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF9BC523)),
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
                  
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product['price'] ?? 0} Đ',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Đã bán ${product['sold'] ?? 0}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

            
          ],
        ),
      ),
    );
  }
}

class SaleProductCard extends StatelessWidget {
  final Map product;
  const SaleProductCard({Key? key, required this.product}) : super(key: key);

  Widget _buildImage(String? imageUrl,
      {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: const Icon(Icons.image_not_supported),
      );
    }

    return Image.network(
      'https://api.vuagaovn.com$imageUrl',
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: const Icon(Icons.error_outline),
      ),
      loadingBuilder: (_, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  String calculateDiscountPercentage(String? priceStr, String? discountedStr) {
    try {
      
      final price = double.tryParse(priceStr?.replaceAll(RegExp(r'[^0-9]'), '') ?? '');
      final discounted = double.tryParse(discountedStr?.replaceAll(RegExp(r'[^0-9]'), '') ?? '');

      if (price != null && discounted != null && price > 0 && discounted < price) {
        final percent = ((price - discounted) / price * 100).round();
        return '-$percent%';
      }
    } catch (e) {
      print('Error calculating discount: $e');
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final productId = product['id']?.toString();
    final soldCount = product['sold'] ?? 0;
    final price = product['price']?.toString();
    final priceAfterDiscount = product['priceAfterDiscount']?.toString();

    
    print('Price: $price, Discount: $priceAfterDiscount');
    final discountPercent = controller.calculateDiscountPercentage(price, priceAfterDiscount);
    print('Calculated discount: $discountPercent');

    return InkWell(
      onTap: () {
        if (productId != null) {
          Get.toNamed(Routes.PRODUCTS_DETAIL,
              arguments: {'productId': productId});
        }
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              margin: EdgeInsets.zero,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(4)),
                    child: _buildImage(product['image']?.toString(),
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 40,
                      child: Text(
                        product['name']?.toString() ?? 'No name',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Color(0xFF9BC523)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${priceAfterDiscount ?? price}',
                          style: const TextStyle(
                            color: Colors.red,
                            
                          ),
                        ),
                        if (discountPercent.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$price Đ',
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12,
                                    color: Colors.grey),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  discountPercent,
                                  style: const TextStyle(
                                      color: Colors.white, 
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFF9BC523),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                '$soldCount',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
