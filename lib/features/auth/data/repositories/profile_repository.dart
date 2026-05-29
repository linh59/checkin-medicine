import 'package:checkin_medicine/features/auth/data/models/managed_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ProfileRepository {
  final _supabase =
      Supabase.instance.client;

  Future<
      List<
          ManagedProfileModel>>
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
            birth_year,
            group_kinds,
            linked_user_id,
            created_by
          ''')
        .order(
      'created_at',
      ascending: true,
    );

    return response
        .map<
        ManagedProfileModel>(
          (e) =>
          ManagedProfileModel
              .fromMap(
            e,
          ),
    )
        .toList();
  }
}