import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import '../../data/models/ingredient_form_model.dart';
import '../../data/models/interaction_model.dart';
import '../../data/repositories/ingredient_form_repository.dart';

final ingredientFormRepoProvider =
Provider(
      (ref) =>
      IngredientFormRepository(
        Supabase.instance.client,
      ),
);

final ingredientFormProvider =
FutureProvider.family<
    IngredientForm?,
    String>(
      (
      ref,
      slug,
      ) async {
    return ref
        .read(
      ingredientFormRepoProvider,
    )
        .getFormBySlug(slug);
  },
);

final interactionProvider =
FutureProvider.family<
    List<Interaction>,
    String>(
      (
      ref,
      formId,
      ) async {
    return ref
        .read(
      ingredientFormRepoProvider,
    )
        .getInteractions(
      formId,
    );
  },
);