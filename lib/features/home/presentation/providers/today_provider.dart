import 'package:checkin_medicine/features/home/data/models/today_timeline_group_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/profile_provider.dart';
import '../../data/repositories/today_repository.dart';

final todayRepositoryProvider = Provider((ref) => TodayRepository());

final todayTimelineProvider = FutureProvider<List<TodayTimelineGroup>>((
  ref,
) async {
  final profile = ref.watch(profileProvider);

  final profileId = profile.profile?.id;

  if (profileId == null) {
    return [];
  }

  return ref.read(todayRepositoryProvider).getTodayTimeline(profileId);
});
