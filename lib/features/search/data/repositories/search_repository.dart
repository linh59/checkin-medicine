import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/medicine_model.dart';
import '../models/nutrient_model.dart';

class SearchRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<MedicineModel>> searchMedicines(String term) async {
    final keyword = term.trim();

    dynamic query = _client.from('medicines').select('''
id,
slug,
brand,
generic_name,
manufacturer,
form,
summary
''');

    // search keyword
    if (keyword.isNotEmpty) {
      query = query.or(
        'brand.ilike.%$keyword%,generic_name.ilike.%$keyword%,manufacturer.ilike.%$keyword%',
      );
    }

    final response = await query.limit(30);
    return (response as List).map((e) => MedicineModel.fromJson(e)).toList();
  }

  Future<List<NutrientModel>> searchNutrients(String term) async {
    final keyword = term.trim();

    dynamic query = _client.from('nutrients').select('''
id,
slug,
name,
category,
summary
''');

    if (keyword.isNotEmpty) {
      query = query.or('name.ilike.%$keyword%,slug.ilike.%$keyword%');
    }

    final response = await query.limit(30);

    return (response as List).map((e) => NutrientModel.fromJson(e)).toList();
  }
}
