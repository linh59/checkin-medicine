import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.spa,
              size: 72,
              color:
              WellnessColors.primary,
            ),

            SizedBox(height: 12),

            Text(
              'CalmCare',
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            SizedBox(height: 6),

            Text(
              'Your health companion',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}