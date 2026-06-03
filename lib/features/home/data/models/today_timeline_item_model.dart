class TodayTimelineItem {
  final String scheduleId;
  final String planItemId;
  final String myMedicineId;

  final String medicineName;

  final String nickname;

  final double dose;

  final String timeOfDay;

  final String? withFood;

  final String? notes;

  final bool taken;
  final String? planName;

  const TodayTimelineItem({
    required this.scheduleId,
    required this.planItemId,
    required this.myMedicineId,
    required this.medicineName,
    required this.nickname,
    required this.dose,
    required this.timeOfDay,
    required this.withFood,
    required this.notes,
    required this.taken,
    this.planName,
  });

  TodayTimelineItem copyWith({bool? taken}) {
    return TodayTimelineItem(
      scheduleId: scheduleId,
      planItemId: planItemId,
      myMedicineId: myMedicineId,
      medicineName: medicineName,
      nickname: nickname,
      dose: dose,
      timeOfDay: timeOfDay,
      withFood: withFood,
      notes: notes,
      taken: taken ?? this.taken,
      planName: planName,
    );
  }
}
