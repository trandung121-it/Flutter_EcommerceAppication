import 'package:get/get.dart';
import 'package:shopping/app/core/base_response.dart';
import 'package:shopping/app/modules/dashboard/models/dashboard_model.dart';
import 'package:shopping/app/services/http_provider.dart';

class DashboardProvider extends GetConnect {
  // Base URL của API NestJS
  final String baseUrl = 'http://localhost:3000';
  final HttpProvider http;

  DashboardProvider({required this.http});

  Future<BaseResponse?> loadData(DashboardModel dashboardModel) async {
    try {
      final response = await get('$baseUrl/dashboard');
      
      if (response.statusCode == 200) {
        return BaseResponse(
          statusCode: response.statusCode,
          statusText: response.statusText,
          status: 1, // API NestJS trả về success
          data: response.body['data'] ?? {},
          message: response.body['message'] ?? 'Success',
        );
      } else {
        return BaseResponse(
          statusCode: response.statusCode,
          statusText: response.statusText,
          status: 0,
          data: {},
          message: 'Failed to load dashboard data',
        );
      }
    } catch (error) {
      print('Dashboard API Error: $error');
      return BaseResponse(
        statusCode: 500,
        statusText: error.toString(),
        status: 0,
        data: {},
        message: 'Network error: $error',
      );
    }
  }
}