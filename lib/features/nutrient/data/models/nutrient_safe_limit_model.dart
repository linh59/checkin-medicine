class NutrientSafeLimitModel {
  final String id;

  final String groupKind;

  final double? rda;
  final double? ul;

  final String? notes;

  NutrientSafeLimitModel({
    required this.id,
    required this.groupKind,
    required this.rda,
    required this.ul,
    required this.notes,
  });

  factory NutrientSafeLimitModel
      .fromJson(
      Map<String, dynamic> json,
      ) {
    return NutrientSafeLimitModel(
      id:
      json['id']
          .toString(),

      groupKind:
      json['group_kind'] ??
          '',

      rda:
      double.tryParse(
        json['rda']
            ?.toString() ??
            '',
      ),

      ul:
      double.tryParse(
        json['ul']
            ?.toString() ??
            '',
      ),

      notes:
      json['notes'],
    );
  }
}