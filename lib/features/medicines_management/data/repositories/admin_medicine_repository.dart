import 'package:checkin_medicine/features/medicines_management/data/models/medicine_form.dart';
import 'package:checkin_medicine/features/nutrient/data/models/ingredient_form_model.dart';
import 'package:checkin_medicine/features/nutrient/data/models/nutrient_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminMedicineRepository {
  final SupabaseClient _client = Supabase.instance.client;


  Future<String> createMedicine(MedicineForm model) async {
    final row = await _client
        .from('medicines')
        .insert({
          'brand': model.brand,
          'generic_name': model.genericName,
          'slug': model.slug,
          'form': model.form,
          'category': model.category,
          'country': model.country,
          'manufacturer': model.manufacturer,
          'summary': model.summary,
          'description': model.description,
          'pills_per_serving': model.pillsPerServing,
          'warnings': model.warnings,
          'source_name': model.sourceName,
          'source_url': model.sourceUrl
        })
        .select()
        .single();

    final medicineId = row['id'];

    if (model.ingredients.isNotEmpty) {
      await _client
          .from('medicine_ingredients')
          .insert(
            model.ingredients
                .map(
                  (e) => {
                    'medicine_id': medicineId,
                    'form_id': e.formId,
                    'amount_per_serving': e.amountPerServing,
                    'unit': e.unit,
                  },
                )
                .toList(),
          );
    }

    return medicineId;
  }
  Future<List<NutrientModel>> searchNutrients(String term) async {
    final keyword = term.trim();

    dynamic query = _client
        .from('nutrients')
        .select('''
id,
slug,
name,
unit,
category,
summary
''');

    if (keyword.isNotEmpty) {
      query = query.or(
        'name.ilike.%$keyword%,slug.ilike.%$keyword%',
      );
    }

    final response = await query
        .order('name')
        .limit(20);

    return response
        .map<NutrientModel>(
          (e) => NutrientModel.fromJson(e),
    )
        .toList();
  }

  Future<List<IngredientForm>> getFormsByNutrient(String nutrientId) async {
    final response = await _client
        .from('ingredient_forms')
        .select()
        .eq('nutrient_id', nutrientId)
        .order('name');

    return response
        .map<IngredientForm>((e) => IngredientForm.fromJson(e))
        .toList();
  }
}
