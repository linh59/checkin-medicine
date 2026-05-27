import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/medicine_detail_model.dart';

class MedicineRepository {
  final SupabaseClient _client =
      Supabase.instance.client;

  Future<MedicineDetailModel?>
  getMedicineDetail(
      String slug,
      ) async {
    final response =
    await _client
        .from('medicines')
        .select(
      '''
*,
medicine_ingredients (
  id,
  amount_per_pill,
  unit,
  percent_dv,
  ingredient_forms (
    id,
    slug,
    name,
    salt_form,
    bioavailability,
    nutrients (
      id,
      slug,
      name,
      unit
    )
  )
)
''',
    )
        .eq('slug', slug)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return MedicineDetailModel
        .fromJson(response);
  }
}