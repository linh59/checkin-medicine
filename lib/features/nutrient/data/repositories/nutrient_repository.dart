import 'package:checkin_medicine/features/nutrient/data/models/nutrient_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class NutrientRepository {
  final _client = Supabase.instance.client;

  NutrientRepository(SupabaseClient client);

  Future<NutrientModel?>
  getNutrientBySlug(
      String slug,
      ) async {
    final response =
    await _client
        .from('nutrients')
        .select('''
      *,
      ingredient_forms (
        id,
        slug,
        name,
        salt_form,
        bioavailability
      ),

      nutrient_safe_limits (
        id,
        group_kind,
        rda,
        ul,
        notes
      )
    ''')
        .eq(
      'slug',
      slug,
    )
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return NutrientModel
        .fromJson(response);
  }
}