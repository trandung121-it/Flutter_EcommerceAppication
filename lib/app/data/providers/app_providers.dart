import 'package:get/get.dart';
import 'package:shopping/app/services/http_provider.dart';

class AppProvider extends GetConnect {
  AppProvider(this.http);

  final HttpProvider http;
}
