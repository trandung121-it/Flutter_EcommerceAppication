import 'package:shopping/app/core/base_api_model.dart';

class HomeModel extends BaseApiModel {
  String? userId;

  HomeModel({this.userId, act, plus}) : super(act: act, plus: plus);

  factory HomeModel.initial() {
    return HomeModel(userId: '', act: '', plus: '');
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "act": act,
      "plus": plus,
    };
  }
}
