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
        .eq('archived', false)
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
  archived,
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
    archived,
    created_at
  )
)
''')
        .eq('id', id)
        .single();
    final planItems = (response['plan_items'] as List<dynamic>? ?? [])
        .where((e) => e['archived'] != true)
        .map((e) {
          e['plan_schedule'] = (e['plan_schedule'] as List<dynamic>? ?? [])
              .where((s) => s['archived'] != true)
              .toList();

          return e;
        })
        .where((e) => (e['plan_schedule'] as List).isNotEmpty)
        .toList();

    response['plan_items'] = planItems;

    return TimelineDetailModel.fromJson(response);
  }

  Future<void> toggleTimeline(String id, bool active) async {
    await supabase.from('plans').update({'is_active': active}).eq('id', id);
  }

  Future<void> toggleNotify(String slotId, bool enabled, int offsetMin) async {
    await supabase
        .from('plan_schedule')
        .update(
        {'notify_enabled': enabled,
          'notify_offset_min': offsetMin})
        .eq('id', slotId);
  }



  Future<void> deletePlanRepository(String id) async {
    await supabase.rpc(
      'toggle_archive_plan',
      params: {
        'p_plan_id': id,
        'p_is_archived': true,
      },
    );
  }

  Future<String> createPlan({
    required String profileId,
    required String name,
  }) async {
    final result = await supabase
        .from('plans')
        .insert({
          'profile_id': profileId,
          'name': name,
          'mode': 'manual',
          'is_active': true,
          'color': 'amber',
        })
        .select('id')
        .single();

    return result['id'] as String;
  }

  Future<void> addToPlan({
    required String planId,
    required String myMedicineId,
    required double dose,
    required String time,
    String? withFood,
  }) async {
    final existing = await supabase
        .from('plan_items')
        .select('id')
        .eq('plan_id', planId)
        .eq('my_medicine_id', myMedicineId)
        .eq('archived', false)
        .maybeSingle();

    String planItemId;

    if (existing != null) {
      planItemId = existing['id'];
    } else {
      final created = await supabase
          .from('plan_items')
          .insert({
            'plan_id': planId,
            'my_medicine_id': myMedicineId,
            'dose_per_take': dose,
            'repeat_kind': 'daily',
            'repeat_interval': 1,
            'total_per_day': dose,
          })
          .select('id')
          .single();

      planItemId = created['id'];
    }

    await supabase.from('plan_schedule').insert({
      'plan_item_id': planItemId,
      'time_of_day': '$time:00',
      'with_food': withFood,
    });
  }

  Future<void> addTdddoPlan({
    required String planId,
    required String myMedicineId,
    required double dose,
    required String time,
    String? withFood,
  }) async {
    final existing = await supabase
        .from('plan_items')
        .select('id')
        .eq('plan_id', planId)
        .eq('my_medicine_id', myMedicineId)
        .maybeSingle();

    String planItemId;

    if (existing != null) {
      planItemId = existing['id'];
    } else {
      final created = await supabase
          .from('plan_items')
          .insert({
            'plan_id': planId,
            'my_medicine_id': myMedicineId,
            'dose_per_take': dose,
            'repeat_kind': 'daily',
            'repeat_interval': 1,
            'total_per_day': dose,
          })
          .select('id')
          .single();

      planItemId = created['id'];
    }

    await supabase.from('plan_schedule').insert({
      'plan_item_id': planItemId,
      'time_of_day': '$time:00',
      'with_food': withFood,
    });
  }

  Future<void> updatePlanItem({
    required String slotId,
    required String planItemId,
    required double dose,
    required String time,
    String? withFood,
  }) async {
    await supabase
        .from('plan_items')
        .update({'dose_per_take': dose})
        .eq('id', planItemId);

    await supabase
        .from('plan_schedule')
        .update({'time_of_day': '$time:00', 'with_food': withFood})
        .eq('id', slotId);
  }


  Future<void> deletePlanItem(String slotId) async {
    final schedule = await supabase
        .from('plan_schedule')
        .select('plan_item_id')
        .eq('id', slotId)
        .single();

    final planItemId = schedule['plan_item_id'];

    await supabase
        .from('plan_schedule')
        .update({'archived': true})
        .eq('id', slotId);

    final remain = await supabase
        .from('plan_schedule')
        .select('id')
        .eq('plan_item_id', planItemId)
        .eq('archived', false);

    if (remain.isEmpty) {
      await supabase
          .from('plan_items')
          .update({'archived': true})
          .eq('id', planItemId);
    }
  }
}
