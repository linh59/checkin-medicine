class NumberFormatter {
  const NumberFormatter._();

  /// Format số:
  /// 600.0 -> 600
  /// 600.5 -> 600.5
  /// 600.25 -> 600.25
  static String clean(
      num? value,
      ) {
    if (value == null) {
      return '-';
    }

    final doubleValue =
    value.toDouble();

    if (doubleValue ==
        doubleValue.toInt()) {
      return doubleValue
          .toInt()
          .toString();
    }

    return doubleValue
        .toString();
  }

  /// 600 + mg => 600mg
  /// 600.5 + mg => 600.5mg
  static String withUnit(
      num? value,
      String? unit,
      ) {
    final formatted =
    clean(value);

    if (unit == null ||
        unit.trim().isEmpty) {
      return formatted;
    }

    return '$formatted$unit';
  }

  /// 600mg · 50% DV
  static String dosage({
    required num? amount,
    String? unit,
    num? percentDv,
  }) {
    final dose =
    withUnit(
      amount,
      unit,
    );

    if (percentDv == null) {
      return dose;
    }

    return '$dose · '
        '${clean(percentDv)}% DV';
  }

  /// Currency-safe decimal
  /// 600 -> 600.00
  /// 600.5 -> 600.50
  static String decimal(
      num? value, {
        int fractionDigits = 2,
      }) {
    if (value == null) {
      return '-';
    }

    return value
        .toDouble()
        .toStringAsFixed(
      fractionDigits,
    );
  }
}