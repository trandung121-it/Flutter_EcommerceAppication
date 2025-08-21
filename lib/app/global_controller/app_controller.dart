import 'package:get/get.dart';
import 'package:shopping/app/core/cache_manager.dart';
import 'package:shopping/app/data/repository/app_repository.dart';

class AppController extends GetxController with CacheManager {
  AppController(this.appRepository);

  final AppRepository appRepository;
}
