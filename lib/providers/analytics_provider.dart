import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/monitoring_service.dart';

final analyticsProvider = Provider<MonitoringService>((ref) {
  return MonitoringService();
});
