import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../my_app_mobile.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.context, this.color});
  final BuildContext context;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Column(
          children: [
            LoadingIndicator(
              indicatorType: Indicator.ballClipRotateMultiple,
              colors: [
                color != null ? color! : secondaryColor,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
