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

  /// IMPORTANT
  final List<MedicineIngredient>
  ingredients;

  Medicine({
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
  });

  factory Medicine.fromJson(
      Map<String, dynamic> json,
      ) {
    return Medicine(
      id: json['id'].toString(),
      slug: json['slug'] ?? '',

      brand: json['brand'] ?? '',
      genericName:
      json['generic_name'] ?? '',
      manufacturer:
      json['manufacturer'] ?? '',

      form: json['form'] ?? '',
      servingSize:
      json['serving_size'] ?? '',

      imageUrl: json['image_url'],

      summary: json['summary'],
      description:
      json['description'],

      warnings: _parseList(
        json['warnings'],
      ),

      category: json['category'],
      country: json['country'],

      strength: json['strength'],
      strengthUnit:
      json['strength_unit'],

      isDeleted:
      json['is_deleted'] ==
          true ||
          json['is_deleted']
              ?.toString() ==
              'true',

      createdBy:
      json['created_by'],

      pillsPerServing:
      int.tryParse(
        json['pills_per_serving']
            ?.toString() ??
            '',
      ),

      /// Parse relation
      ingredients:
      (json[
      'medicine_ingredients']
      as List?)
          ?.map(
            (e) =>
            MedicineIngredient
                .fromJson(e),
      )
          .toList() ??
          [],
    );
  }

  static List<String> _parseList(
      dynamic value,
      ) {
    if (value == null) {
      return [];
    }

    if (value is List) {
      return value
          .map(
            (e) => e.toString(),
      )
          .toList();
    }

    if (value is String) {
      try {
        final decoded =
        jsonDecode(value);

        if (decoded is List) {
          return decoded
              .map(
                (e) => e.toString(),
          )
              .toList();
        }
      } catch (_) {}
    }

    return [];
  }
}