import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/nutrient_model.dart';
import '../../data/repositories/nutrient_repository.dart';

/// Repository Provider
final nutrientRepositoryProvider =
Provider<
    NutrientRepository>(
      (ref) {
    return NutrientRepository(
      Supabase.instance.client,
    );
  },
);

/// Detail Provider
final nutrientDetailProvider =
FutureProvider.family<
    NutrientModel?,
    String>(
      (
      ref,
      slug,
      ) async {
    return ref
        .read(
      nutrientRepositoryProvider,
    )
        .getNutrientBySlug(
      slug,
    );
  },
);