import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shopping/app/core/base_response.dart';
import 'package:shopping/app/modules/home/models/home_model.dart';
import 'package:shopping/app/services/http_provider.dart';

class HomeProvider extends GetConnect {
  Map<String, dynamic> _defaultBody = {
    'app_key': dotenv.env['APPKEY'],
    'op': dotenv.env['OPTION'],
    'ver': dotenv.env['VER'],
  };

  final HttpProvider http;

  HomeProvider({required this.http});

  Future<BaseResponse?> loadData(HomeModel homeModel) async {
    Map<String, dynamic> submit = Map<String, dynamic>();
    submit.addAll(_defaultBody);
    submit.addAll(homeModel.toMap());
    return await http.doPost("", submit).then((response) {
      return BaseResponse(
          statusCode: response.statusCode,
          statusText: response.statusMessage,
          status: response.data['error'],
          data: response.data['data'] ?? {},
          message:
              response.data['message'] != null ? response.data['message'] : "");
    }).catchError((onError) {
      return BaseResponse(statusText: onError.toString(), statusCode: 400);
    });
  }
}
