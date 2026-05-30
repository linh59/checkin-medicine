import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/timeline_detail_model.dart';
import '../../data/repositories/timeline_repository.dart';

final timelineRepositoryProvider = Provider((ref) => TimelineRepository());

final timelineDetailProvider =
    FutureProvider.family<TimelineDetailModel, String>((ref, id) async {
      return ref.read(timelineRepositoryProvider).getTimelineDetail(id);
    });
