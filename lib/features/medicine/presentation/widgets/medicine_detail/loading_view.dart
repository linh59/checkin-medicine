import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/medicine_detail_model.dart';

class LoadingView
    extends StatelessWidget {
  const LoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:
      CircularProgressIndicator(),
    );
  }
}
