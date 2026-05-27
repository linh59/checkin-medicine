class NutrientSafeLimitModel {
  final String id;
  final String groupKind;
  final double? rda;
  final double? ul;
  final String? notes;

  NutrientSafeLimitModel({
    required this.id,
    required this.groupKind,
    this.rda,
    this.ul,
    this.notes,
  });

  factory NutrientSafeLimitModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return NutrientSafeLimitModel(
      id: json['id'],
      groupKind:
      json['group_kind'],
      rda: (json['rda']
      as num?)
          ?.toDouble(),
      ul: (json['ul']
      as num?)
          ?.toDouble(),
      notes: json['notes'],
    );
  }
}