import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/ingredient_form_model.dart';
import '../../data/repositories/form_repository.dart';

final formRepositoryProvider = Provider((ref) => FormRepository());

final formDetailProvider =
FutureProvider.family<IngredientForm?, String>((ref, slug) async {
  final repo = ref.read(formRepositoryProvider);
  return repo.getFormBySlug(slug);
});