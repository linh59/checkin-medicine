import 'package:checkin_medicine/features/home/data/models/today_timeline_item_model.dart';

class TodayTimelineGroup {
  final String time;

  final List<TodayTimelineItem> items;

  const TodayTimelineGroup({required this.time, required this.items});
}
