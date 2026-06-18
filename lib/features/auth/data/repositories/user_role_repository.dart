import 'package:checkin_medicine/features/auth/domain/app_role.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class UserRoleRepository {
  final SupabaseClient _supabase;

  UserRoleRepository(this._supabase);

  Future<AppRole?> getRole(String userId) async {
    final result = await _supabase
        .from('user_roles')
        .select('role')
        .eq('user_id', userId)
        .maybeSingle();

    if (result == null) {
      return null;
    }

    final role = result['role'] as String?;

    return role?.toAppRole();
  }
}