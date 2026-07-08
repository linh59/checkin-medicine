import 'dart:convert';

import 'medicine_ingredient.dart';

class Medicine {
  final String id;
  final String slug;

  final String brand;
  final String genericName;
  final String manufacturer;

  final String form;
  final String servingSize;

  final String? imageUrl;

  final String? summary;
  final String? description;

  final List<String> warnings;

  final String? category;
  final String? country;

  final String? strength;
  final String? strengthUnit;

  final bool isDeleted;

  final String? createdBy;
  final int? pillsPerServing;

  final String sourceName;
  final String? sourceUrl;

  /// Ingredients
  final List<MedicineIngredient> ingredients;

  const Medicine({
    required this.id,
    required this.slug,
    required this.brand,
    required this.genericName,
    required this.manufacturer,
    required this.form,
    required this.servingSize,
    required this.imageUrl,
    required this.summary,
    required this.description,
    required this.warnings,
    required this.category,
    required this.country,
    required this.strength,
    required this.strengthUnit,
    required this.isDeleted,
    required this.createdBy,
    required this.pillsPerServing,
    required this.ingredients,
    required this.sourceName,
    required this.sourceUrl,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    final ingredientList =
    (json['medicine_ingredients'] as List<dynamic>? ?? []);

    return Medicine(
      id: json['id']?.toString() ?? '',

      slug: json['slug']?.toString() ?? '',

      brand: json['brand']?.toString() ?? '',

      genericName: json['generic_name']?.toString() ?? '',

      manufacturer: json['manufacturer']?.toString() ?? '',

      form: json['form']?.toString() ?? '',

      servingSize: json['serving_size']?.toString() ?? '',

      imageUrl: json['image_url']?.toString(),

      summary: json['summary']?.toString(),

      description: json['description']?.toString(),

      warnings: _parseList(json['warnings']),

      category: json['category']?.toString(),

      country: json['country']?.toString(),

      strength: json['strength']?.toString(),

      strengthUnit: json['strength_unit']?.toString(),

      isDeleted: json['is_deleted'] == true,

      createdBy: json['created_by']?.toString(),

      pillsPerServing: json['pills_per_serving'] == null
          ? null
          : int.tryParse(
        json['pills_per_serving'].toString(),
      ),

      ingredients: ingredientList
          .map(
            (e) => MedicineIngredient.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),

      sourceName: json['source_name']?.toString() ?? '',

      sourceUrl: json['source_url']?.toString(),
    );
  }

  static List<String> _parseList(dynamic value) {
    if (value == null) {
      return [];
    }

    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }

    if (value is String) {
      try {
        final decoded = jsonDecode(value);

        if (decoded is List) {
          return decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {}
    }

    return [];
  }
}