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
          ),

          plan_items (
            id,
            archived
          )
        ''')
        .eq('profile_id', profileId)
        .eq('archived', false)
        .order('created_at', ascending: false);

    return response.map<MyMedicineModel>((e) {
      final plans = (e['plan_items'] as List<dynamic>? ?? [])
          .where((p) => p['archived'] != true)
          .toList();

      return MyMedicineModel.fromMap({...e, 'can_delete': plans.isEmpty});
    }).toList();
  }

  Future<void> deleteMedicine(MyMedicineModel medicine) async {
    if (!medicine.canDelete) {
      throw Exception('Medicine is being used in active timeline');
    }

    await _supabase
        .from('my_medicines')
        .update({'archived': true})
        .eq('id', medicine.id);
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
