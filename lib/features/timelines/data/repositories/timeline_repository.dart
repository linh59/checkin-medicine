import 'package:checkin_medicine/features/timelines/data/models/timeline_detail_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/plan_model.dart';

class TimelineRepository {
  final supabase = Supabase.instance.client;

  Future<List<PlanModel>> getPlans(String profileId) async {
    final res = await supabase
        .from('plans')
        .select('*, plan_items(count)')
        .eq('profile_id', profileId)
        .order('created_at');

    return (res as List).map((e) => PlanModel.fromJson(e)).toList();
  }

  Future<void> togglePlan(String id, bool active) async {
    await supabase.from('plans').update({'is_active': active}).eq('id', id);
  }

  Future<TimelineDetailModel> getTimelineDetail(String id) async {
    final response = await supabase
        .from('plans')
        .select('''
id,
name,
notes,
profile_id,
is_active,
color,
mode,

managed_profiles:profile_id(
  id,
  full_name,
  birth_year
),

plan_items(
  id,
  dose_per_take,
  repeat_kind,
  repeat_interval,

  my_medicines(
    id,
    nickname,

    medicines(
      id,
      slug,
      brand,
      generic_name
    )
  ),

  plan_schedule(
    id,
    time_of_day,
    weekday_mask,
    with_food,
    notes,
    notify_enabled,
    notify_offset_min,
    notify_sound,
    created_at
  )
)
''')
        .eq('id', id)
        .single();

    return TimelineDetailModel.fromJson(response);
  }

  Future<void> toggleTimeline(String id, bool active) async {
    await supabase.from('plans').update({'is_active': active}).eq('id', id);
  }

  Future<void> toggleNotify(String slotId, bool enabled) async {
    await supabase
        .from('plan_schedule')
        .update({'notify_enabled': enabled})
        .eq('id', slotId);
  }

  Future<void> deleteTimeline(String id) async {
    await supabase.from('plans').delete().eq('id', id);
  }
}
