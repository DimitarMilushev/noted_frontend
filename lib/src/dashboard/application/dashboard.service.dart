import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard.service.g.dart';

@Riverpod()
DashboardService dashboardService(DashboardServiceRef ref) =>
    DashboardService();

class DashboardService {
  FutureOr<void> build() {}
}
