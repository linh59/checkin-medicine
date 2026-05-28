import 'package:checkin_medicine/features/nutrient/data/models/ingredient_form_model.dart';


class Interaction {
  final String id;

  final String aFormId;
  final String bFormId;

  final String severity;
  final String description;
  final String? recommendation;

  final IngredientForm? a;
  final IngredientForm? b;

  Interaction({
    required this.id,
    required this.aFormId,
    required this.bFormId,
    required this.severity,
    required this.description,
    required this.recommendation,
    required this.a,
    required this.b,
  });

  factory Interaction.fromJson(
      Map<String, dynamic> json,
      ) {
    return Interaction(
      id:
      json['id']
          .toString(),

      aFormId:
      json['a_form_id']
          .toString(),

      bFormId:
      json['b_form_id']
          .toString(),

      severity:
      json['severity'] ??
          '',

      description:
      json['description'] ??
          '',

      recommendation:
      json[
      'recommendation'],

      a: json['a'] != null
          ? IngredientForm
          .fromJson(
        json['a'],
      )
          : null,

      b: json['b'] != null
          ? IngredientForm
          .fromJson(
        json['b'],
      )
          : null,
    );
  }
}