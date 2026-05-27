import 'ingredient_form_model.dart';
import 'nutrient_safe_limit_model.dart';

class NutrientDetailModel {
  final String id;
  final String slug;
  final String name;
  final String? summary;
  final String? whyMatters;
  final String? category;
  final String? unit;

  final List<IngredientFormModel>
  ingredientForms;

  final List<NutrientSafeLimitModel>
  safeLimits;

  NutrientDetailModel({
    required this.id,
    required this.slug,
    required this.name,
    this.summary,
    this.whyMatters,
    this.category,
    this.unit,
    required this.ingredientForms,
    required this.safeLimits,
  });

  factory NutrientDetailModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return NutrientDetailModel(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      summary: json['summary'],
      whyMatters:
      json['why_matters'],
      category:
      json['category'],
      unit: json['unit'],

      ingredientForms:
      (json[
      'ingredient_forms']
      as List?)
          ?.map(
            (e) =>
            IngredientFormModel
                .fromJson(e),
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
                .fromJson(e),
      )
          .toList() ??
          [],
    );
  }
}