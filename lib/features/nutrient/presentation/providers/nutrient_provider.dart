import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/nutrient_detail_model.dart';
import '../../data/repositories/nutrient_repository.dart';

final nutrientRepositoryProvider =
Provider(
      (ref) =>
      NutrientRepository(),
);

final nutrientDetailProvider =
FutureProvider.family<
    NutrientDetailModel?,
    String>(
      (ref, slug) {
    return ref
        .read(
      nutrientRepositoryProvider,
    )
        .getNutrient(slug);
  },
);