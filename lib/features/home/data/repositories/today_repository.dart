import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/today_timeline_group_model.dart';
import '../models/today_timeline_item_model.dart';

class TodayRepository {
  final _supabase = Supabase.instance.client;

  Future<List<TodayTimelineGroup>> getTodayTimeline(String profileId) async {
    final plans = await _supabase
        .from('plans')
        .select('''
          id,
          name,
          color,

          plan_items(
            id,
            dose_per_take,
            archived,

            my_medicines(
              id,
              nickname,
              archived,

              medicines(
                brand,
                generic_name
              )
            ),

            plan_schedule(
              id,
              time_of_day,
              with_food,
              notes,
              archived
            )
          )
        ''')
        .eq('profile_id', profileId)
        .eq('is_active', true);

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));

    final logs = await _supabase
        .from('intake_logs')
        .select('plan_schedule_id, status')
        .eq('profile_id', profileId)
        .gte('taken_at', start.toIso8601String())
        .lt('taken_at', end.toIso8601String());

    final takenSet = logs
        .where((e) => (e['status'] ?? '') == 'taken')
        .map((e) => e['plan_schedule_id']?.toString())
        .whereType<String>()
        .toSet();

    final items = <TodayTimelineItem>[];

    for (final plan in plans) {
      final planItems = plan['plan_items'] as List<dynamic>? ?? [];

      for (final item in planItems) {
        if (item['archived'] == true) continue;

        final schedules = (item['plan_schedule'] as List<dynamic>? ?? [])
            .where((e) => e['archived'] != true)
            .toList();

        final medicine = item['my_medicines'] ?? {};
        final medicineInfo = medicine['medicines'] ?? {};

        final nickname = (medicine['nickname'] ?? '').toString();
        final brand = (medicineInfo['brand'] ?? '').toString();

        for (final schedule in schedules) {
          final scheduleId = schedule['id']?.toString() ?? '';

          items.add(
            TodayTimelineItem(
              scheduleId: scheduleId,
              planItemId: item['id']?.toString() ?? '',
              myMedicineId: medicine['id']?.toString() ?? '',
              medicineName: nickname.trim().isNotEmpty ? nickname : brand,
              nickname: nickname,
              dose: double.tryParse(item['dose_per_take'].toString()) ?? 1,
              timeOfDay: schedule['time_of_day']?.toString() ?? '08:00:00',
              withFood: schedule['with_food']?.toString(),
              notes: schedule['notes']?.toString(),
              taken: takenSet.contains(scheduleId),
              planName: plan['name']?.toString(),
            ),
          );
        }
      }
    }

    final grouped = <String, List<TodayTimelineItem>>{};

    for (final item in items) {
      grouped.putIfAbsent(item.timeOfDay, () => []);
      grouped[item.timeOfDay]!.add(item);
    }

    final result = grouped.entries
        .map((e) => TodayTimelineGroup(time: e.key, items: e.value))
        .toList();

    result.sort((a, b) => a.time.compareTo(b.time));

    return result;
  }

  Future<void> markAsTaken({
    required String profileId,
    required String scheduleId,
    required String myMedicineId,
  }) async {
    await _supabase.from('intake_logs').upsert({
      'profile_id': profileId,
      'my_medicine_id': myMedicineId,
      'plan_schedule_id': scheduleId,
      'status': 'taken',
      'taken_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> undoTaken({
    required String profileId,
    required String scheduleId,
  }) async {
    await _supabase
        .from('intake_logs')
        .delete()
        .eq('profile_id', profileId)
        .eq('plan_schedule_id', scheduleId);
  }
}
