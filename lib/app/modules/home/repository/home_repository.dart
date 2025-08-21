import 'package:shopping/app/core/base_response.dart';
import 'package:shopping/app/modules/home/models/home_model.dart';
import 'package:shopping/app/modules/home/provider/home_provider.dart';

class HomeRepository {
  final HomeProvider homeProvider;

  HomeRepository({required this.homeProvider});

  Future<BaseResponse?> loadData(HomeModel homeModel) =>
      homeProvider.loadData(homeModel);
}
