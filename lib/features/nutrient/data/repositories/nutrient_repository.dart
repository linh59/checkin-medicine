import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/nutrient_detail_model.dart';

class NutrientRepository {
  final supabase =
      Supabase.instance.client;

  Future<NutrientDetailModel?>
  getNutrient(
      String slug,
      ) async {
    final data =
    await supabase
        .from('nutrients')
        .select('''
              *,
              ingredient_forms(
                id,
                slug,
                name,
                salt_form,
                bioavailability
              ),
              nutrient_safe_limits(
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

    if (data == null) {
      return null;
    }

    return NutrientDetailModel
        .fromJson(data);
  }
}