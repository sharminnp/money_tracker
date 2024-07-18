import 'package:flutter/material.dart';
import 'package:msa_money_tracker/core/constants/ui_colors.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: UiColors.primary,
        ),
      ),
    );
  }
}
