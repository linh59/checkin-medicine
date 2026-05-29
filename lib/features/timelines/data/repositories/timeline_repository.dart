import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/plan_model.dart';

class TimelineRepository {
  final client = Supabase.instance.client;

  Future<List<PlanModel>> getPlans(String profileId) async {
    final res = await client
        .from('plans')
        .select('*, plan_items(count)')
        .eq('profile_id', profileId)
        .order('created_at');

    return (res as List).map((e) => PlanModel.fromJson(e)).toList();
  }

  Future<void> togglePlan(String id, bool active) async {
    await client.from('plans').update({'is_active': active}).eq('id', id);
  }
}
