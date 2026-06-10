import 'package:checkin_medicine/features/nutrient/data/models/ingredient_form_model.dart';


class Interaction {
  final String id;

  final String? formId;
  final String? formName;

  final String? interactsWithId;
  final String? interactsWithName;

  final String? severity;
  final String? description;
  final String? recommendation;

  const Interaction({
    required this.id,
    this.formId,
    this.formName,
    this.interactsWithId,
    this.interactsWithName,
    this.severity,
    this.description,
    this.recommendation,
  });

  factory Interaction.fromJson(Map<String, dynamic> json) {
    return Interaction(
      id: json['id'] ?? '',

      formId: json['form_id'],
      formName: json['form_name'],

      interactsWithId: json['interacts_with_id'],
      interactsWithName: json['interacts_with_name'],

      severity: json['severity'],
      description: json['description'],
      recommendation: json['recommendation'],
    );
  }
}