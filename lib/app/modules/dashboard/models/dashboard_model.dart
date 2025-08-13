import 'package:shopping/app/core/base_api_model.dart';

class DashboardModel extends BaseApiModel {
  List<dynamic>? bannerHome;
  List<dynamic>? arrayCategoryProducts;
  List<dynamic>? arrayArticlesNew;
  List<dynamic>? arrayProductsSale;
  List<dynamic>? arrayProductsHome;
  List<dynamic>? arrayProductsAll;
  String? userId;
  int? catId; 

  DashboardModel({
    this.userId,
    this.bannerHome,
    this.arrayCategoryProducts,
    this.arrayArticlesNew,
    this.arrayProductsSale,
    this.arrayProductsHome,
    this.arrayProductsAll,
    this.catId, 
    act,
    plus,
  }) : super(act: act, plus: plus);

  factory DashboardModel.initial() {
    return DashboardModel(
      bannerHome: [],
      arrayArticlesNew: [],
      arrayCategoryProducts: [],
      arrayProductsAll: [],
      arrayProductsHome: [],
      arrayProductsSale: [],
      act: '',
      plus: '',
      userId: '',
      catId: -1, 
    );
  }

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      bannerHome: json["bannerHome"] ?? [],
      arrayCategoryProducts: json["arrayCategoryProducts"] ?? [],
      arrayArticlesNew: json["arrayArticlesNew"] ?? [],
      arrayProductsSale: json["arrayProductsSale"] ?? [],
      arrayProductsHome: json["arrayProductsHome"] ?? [],
      arrayProductsAll: json["arrayProductsAll"] ?? [],
    );
  }

  int? saleRemainingSeconds;

  @override
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "act": act,
      "plus": plus,
      "catId": catId, // <-- Thêm vào đây
    };
  }
}
