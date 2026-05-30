class PlanScheduleModel {
  final String id;
  final String planItemId;

  final String timeOfDay;

  final int weekdayMask;

  final String? withFood;
  final String? notes;

  final bool notifyEnabled;
  final int notifyOffsetMin;
  final String? notifySound;

  final DateTime? createdAt;

  const PlanScheduleModel({
    required this.id,
    required this.planItemId,
    required this.timeOfDay,
    required this.weekdayMask,
    required this.withFood,
    required this.notes,
    required this.notifyEnabled,
    required this.notifyOffsetMin,
    required this.notifySound,
    required this.createdAt,
  });

  factory PlanScheduleModel.fromJson(Map<String, dynamic> json) {
    return PlanScheduleModel(
      id: json['id']?.toString() ?? '',

      planItemId: json['plan_item_id']?.toString() ?? '',

      timeOfDay: json['time_of_day']?.toString() ?? '08:00:00',

      weekdayMask: int.tryParse(json['weekday_mask']?.toString() ?? '') ?? 127,

      withFood: json['with_food']?.toString(),

      notes: json['notes']?.toString(),

      notifyEnabled:
          json['notify_enabled'] == true ||
          json['notify_enabled']?.toString() == 'true',

      notifyOffsetMin:
          int.tryParse(json['notify_offset_min']?.toString() ?? '') ?? 0,

      notifySound: json['notify_sound']?.toString(),

      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
