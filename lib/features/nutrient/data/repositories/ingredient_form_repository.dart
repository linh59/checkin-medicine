import 'package:supabase_flutter/supabase_flutter.dart';


import '../models/ingredient_form_model.dart';
import '../models/interaction_model.dart';

class IngredientFormRepository {
  final SupabaseClient supabase;

  IngredientFormRepository(
      this.supabase,
      );

  Future<IngredientForm?>
  getFormBySlug(
      String slug,
      ) async {
    final data =
    await supabase
        .from(
      'ingredient_forms',
    )
        .select('''
        *,
        nutrients (
          id,
          slug,
          name,
          unit
        )
      ''')
        .eq(
      'slug',
      slug,
    )
        .maybeSingle();

    if (data == null) {
      return null;
    }

    return IngredientForm
        .fromJson(data);
  }

  Future<List<Interaction>>
  getInteractions(
      String formId,
      ) async {
    final response = await supabase
        .rpc('get_interactions', params: {
      'p_form_id': formId,
    });

    return (response as List)
        .map((e) => Interaction.fromJson(e))
        .toList();
  }
}