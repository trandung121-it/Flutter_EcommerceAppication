import 'package:shopping/app/core/base_response.dart';
import 'package:shopping/app/modules/dashboard/models/dashboard_model.dart';
import 'package:shopping/app/modules/dashboard/provider/dashboard_provider.dart';

class DashboardRepository {
  final DashboardProvider dashboardProvider;

  DashboardRepository({required this.dashboardProvider});

  Future<BaseResponse?> loadData(DashboardModel dashboardModel) => 
      dashboardProvider.loadData(dashboardModel);
}