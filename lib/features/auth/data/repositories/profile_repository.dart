import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/managed_profile.dart';

class ProfileRepository {
  final _supabase =
      Supabase.instance.client;

  Future<List<ManagedProfile>>
  getProfiles() async {
    final response =
    await _supabase
        .from(
      'managed_profiles',
    )
        .select('''
              id,
              full_name,
              avatar_url,
              dob,
              birth_year,
              gender,
              group_kinds,
              notes,
              linked_user_id,
              created_by,
              created_at,
              updated_at
            ''')
        .order(
      'created_at',
      ascending: true,
    );

    return response
        .map<ManagedProfile>(
          (e) =>
          ManagedProfile
              .fromMap(e),
    )
        .toList();
  }
}