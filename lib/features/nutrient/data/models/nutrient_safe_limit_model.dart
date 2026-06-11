class NutrientSafeLimitModel {
  final String id;

  final String groupKind;
  final double? rda;
  final double? ul;
  final double? rdaMin;
  final double? rdaMax;

  final double? odaMin;
  final double? odaMax;

  final double? ulMax;

  final String? sex;

  final int? ageMinMonths;
  final int? ageMaxMonths;

  final String? sourceName;
  final String? notes;

  const NutrientSafeLimitModel({
    required this.id,
    required this.groupKind,
    this.rda,
    this.ul,
    this.rdaMin,
    this.rdaMax,
    this.odaMin,
    this.odaMax,
    this.ulMax,
    this.sex,
    this.ageMinMonths,
    this.ageMaxMonths,
    this.sourceName,
    this.notes,
  });

  factory NutrientSafeLimitModel.fromJson(Map<String, dynamic> json) {
    return NutrientSafeLimitModel(
      id: json['id'].toString(),

      groupKind: json['group_kind'] ?? '',
      rda: (json['rda'] as num?)?.toDouble(),

      ul: (json['ul'] as num?)?.toDouble(),

      rdaMin: (json['rda_min'] as num?)?.toDouble(),

      rdaMax: (json['rda_max'] as num?)?.toDouble(),

      odaMin: (json['oda_min'] as num?)?.toDouble(),

      odaMax: (json['oda_max'] as num?)?.toDouble(),

      ulMax: (json['ul_max'] as num?)?.toDouble(),

      sex: json['sex'] as String?,

      ageMinMonths: (json['age_min_months'] as num?)?.toInt(),

      ageMaxMonths: (json['age_max_months'] as num?)?.toInt(),

      sourceName: json['source_name'] as String?,

      notes: json['notes'] as String?,
    );
  }
}
