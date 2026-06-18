import 'package:checkin_medicine/features/medicine/data/models/medicine_detail_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



class MedicineRepository {
  final SupabaseClient supabase;

  MedicineRepository(this.supabase);

  Future<Medicine?> getMedicineBySlug(String slug) async {
    final response = await supabase
        .from('medicines')
        .select('''
          *,
          medicine_ingredients (
            id,
           
            amount_per_pill,
            amount_per_serving,
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
        ''')
        .eq('slug', slug)
        .maybeSingle();

    if (response == null) return null;

    return Medicine.fromJson(response);
  }
}