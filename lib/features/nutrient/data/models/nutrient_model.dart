import 'ingredient_form_model.dart';
import 'nutrient_safe_limit_model.dart';

class NutrientModel {
  final String id;
  final String slug;
  final String name;

  final String? category;
  final String? summary;
  final String? whyMatters;
  final String? unit;

  final List<IngredientForm>
  forms;

  final List<
      NutrientSafeLimitModel>
  safeLimits;

  NutrientModel({
    required this.id,
    required this.slug,
    required this.name,
    required this.category,
    required this.summary,
    required this.whyMatters,
    required this.unit,
    required this.forms,
    required this.safeLimits,
  });

  factory NutrientModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return NutrientModel(
      id:
      json['id']
          ?.toString() ??
          '',

      slug:
      json['slug'] ?? '',

      name:
      json['name'] ?? '',

      category:
      json['category'],

      summary:
      json['summary'],

      whyMatters:
      json[
      'why_matters'],

      unit:
      json['unit']
          ?.toString(),

      forms:
      (json[
      'ingredient_forms']
      as List?)
          ?.map(
            (e) =>
            IngredientForm
                .fromJson(
              e,
            ),
      )
          .toList() ??
          [],

      safeLimits:
      (json[
      'nutrient_safe_limits']
      as List?)
          ?.map(
            (e) =>
            NutrientSafeLimitModel
                .fromJson(
              e,
            ),
      )
          .toList() ??
          [],
    );
  }
}