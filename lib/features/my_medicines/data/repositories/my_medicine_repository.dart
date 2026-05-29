import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/my_medicine_model.dart';

class MyMedicineRepository {
  final _supabase = Supabase.instance.client;

  Future<List<MyMedicineModel>> getMyMedicines(String profileId) async {
    final response = await _supabase
        .from('my_medicines')
        .select('''
              id,
              profile_id,
              medicine_id,
              nickname,
              custom_dose_per_take,
              notes,
              started_at,
              archived,
              created_at,
              updated_at,
              medicines (
                id,
                slug,
                brand,
                generic_name,
                manufacturer,
                form,
                created_by
              )
            ''')
        .eq('profile_id', profileId)
        .eq('archived', false)
        .order('created_at', ascending: false);

    return response
        .map<MyMedicineModel>((e) => MyMedicineModel.fromMap(e))
        .toList();
  }

  Future<void> deleteMedicine(String id) async {
    final response = await _supabase.from('my_medicines').delete().eq('id', id);

    return response;
  }

  Future<void> addMedicine({
    required String profileId,
    required String medicineId,
    String? nickname,
    String? notes,
  }) async {
    await _supabase.from('my_medicines').insert({
      'profile_id': profileId,
      'medicine_id': medicineId,
      'nickname': nickname,
      'notes': notes,
    });
  }
}
