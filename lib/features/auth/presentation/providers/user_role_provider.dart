import 'package:checkin_medicine/features/auth/data/repositories/user_role_repository.dart';
import 'package:checkin_medicine/features/auth/domain/app_role.dart';
import 'package:checkin_medicine/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final userRoleRepositoryProvider =
Provider<UserRoleRepository>((ref) {
  return UserRoleRepository(
    Supabase.instance.client,
  );
});

final currentUserRoleProvider =
FutureProvider<AppRole?>((ref) async {
  final authState = ref.watch(authProvider);

  final user = authState.user;

  if (user == null) {
    return null;
  }

  final repo = ref.read(userRoleRepositoryProvider);

  return repo.getRole(user.id);
});
