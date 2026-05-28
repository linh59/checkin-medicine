import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../medicine/data/models/medicine_detail_model.dart';
import '../models/ingredient_form_model.dart';
import '../models/interaction_model.dart';

class FormRepository {
  final _client = Supabase.instance.client;

  Future<IngredientForm?> getFormBySlug(String slug) async {
    final res = await _client
        .from('ingredient_forms')
        .select()
        .eq('slug', slug)
        .maybeSingle();

    if (res == null) return null;
    return IngredientForm.fromJson(res);
  }

  Future<List<Interaction>> getInteractions(String formId) async {
    final res = await _client
        .from('interactions')
        .select()
        .or('a_form_id.eq.$formId,b_form_id.eq.$formId');

    return (res as List)
        .map((e) => Interaction.fromJson(e))
        .toList();
  }
}