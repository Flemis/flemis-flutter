import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../my_app_mobile.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 200,
        width: 200,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          colors: [
            secondaryColor,
          ],
        ),
      ),
    );
  }
}
