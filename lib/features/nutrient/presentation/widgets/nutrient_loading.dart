import 'package:flutter/material.dart';

class NutrientLoading
    extends StatelessWidget {
  const NutrientLoading({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {
    return const Center(
      child:
      CircularProgressIndicator(),
    );
  }
}