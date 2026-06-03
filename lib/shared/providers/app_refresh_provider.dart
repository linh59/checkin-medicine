import 'package:checkin_medicine/features/home/presentation/providers/today_provider.dart';
import 'package:checkin_medicine/features/my_medicines/presentation/providers/my_medicine_provider.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/timelines_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRefreshProvider = Provider<AppRefreshService>(
  (ref) => AppRefreshService(ref),
);

class AppRefreshService {
  final Ref ref;

  AppRefreshService(this.ref);

  void refreshMedicine() {
    ref.invalidate(myMedicinesProvider);
  }

  void refreshTimeline() {
    ref.invalidate(plansProvider);
    ref.invalidate(todayTimelineProvider);
  }

  void refreshAll() {
    refreshMedicine();
    refreshTimeline();
  }
}
