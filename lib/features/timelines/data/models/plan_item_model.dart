class PlanItemModel {
  final String id;
  final String planId;
  final String myMedicineId;
  final int dosePerTake;
  final String repeatKind;
  final int repeatInterval;
  final int totalPerDay;

  PlanItemModel({
    required this.id,
    required this.planId,
    required this.myMedicineId,
    required this.dosePerTake,
    required this.repeatKind,
    required this.repeatInterval,
    required this.totalPerDay,
  });

  factory PlanItemModel.fromJson(Map<String, dynamic> json) {
    return PlanItemModel(
      id: json['id'],
      planId: json['plan_id'],
      myMedicineId: json['my_medicine_id'],
      dosePerTake: int.tryParse(json['dose_per_take'].toString()) ?? 1,
      repeatKind: json['repeat_kind'] ?? 'daily',
      repeatInterval: int.tryParse(json['repeat_interval'].toString()) ?? 1,
      totalPerDay: int.tryParse(json['total_per_day'].toString()) ?? 1,
    );
  }
}
