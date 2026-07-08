import 'package:checkin_medicine/features/nutrient/data/models/nutrient_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NutrientRepository {
  final SupabaseClient _client;

  NutrientRepository(this._client);

  Future<NutrientModel?> getNutrientBySlug(String slug) async {
    final response = await _client
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

            rda_min,
            rda_max,

            oda_min,
            oda_max,

            ul_max,

            sex,

            age_min_months,
            age_max_months,

            source_name,

            notes,
            source_name,
            source_url
          )
        ''')
        .eq('slug', slug)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return NutrientModel.fromJson(response);
  }
}
